package servlet;

import config.PlacesConfig;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;
import java.util.List;
import java.util.UUID;
import java.sql.SQLException;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/search")
public class PlacesServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String includedTypes = request.getParameter("includedTypes");
        int maxResultCount = Integer.parseInt(request.getParameter("maxResultCount"));
        double centerLatitude = Double.parseDouble(request.getParameter("centerLatitude"));
        double centerLongitude = Double.parseDouble(request.getParameter("centerLongitude"));
        double radius = Double.parseDouble(request.getParameter("radius"));
        String requestBody = buildRequestJson(includedTypes, maxResultCount,
            centerLatitude, centerLongitude, radius);
        URL url = new URL(PlacesConfig.API_BASE_URL + PlacesConfig.REQUEST_API);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("X-Goog-Api-Key", PlacesConfig.API_KEY);
        conn.setRequestProperty("X-Goog-FieldMask", "places.displayName");
        conn.setDoOutput(true);
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }
        StringBuilder result = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                result.append(line);
            }
        }
        HttpSession session = request.getSession();
        session.setAttribute("placesResponse", result.toString());
        response.sendRedirect("result.jsp");
    }

    private String buildRequestJson(String includedTypes, int maxResultCount,
        double centerLatitude, double centerLongitude, double radius) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        // json.append("\"languageCode\":").append("\"zh-TW\"").append(",");
        json.append("\"includedTypes\":[\"").append(includedTypes).append("\"],");
        json.append("\"maxResultCount\":").append(maxResultCount).append(",");
        json.append("\"locationRestriction\":{");
        json.append("\"circle\":{");
        json.append("\"center\":{");
        json.append("\"latitude\":").append(centerLatitude).append(",");
        json.append("\"longitude\":").append(centerLongitude);
        json.append("},");
        json.append("\"radius\":").append(radius);
        json.append("}");
        json.append("}");
        json.append("}");

        return json.toString();
    }

    /**
     * 跳脫 JSON 特殊字元
     */
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\"", "\\\"")
                  .replace("\\", "\\\\")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
