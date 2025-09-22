package servlet;

import config.PlacesConfig;
import service.SQLConversionService;

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

@WebServlet("/to_sql")
public class SQLConversionServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String key = request.getParameter("key");
        if (!key.equals(PlacesConfig.API_KEY)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "API Key error");
            return;
        }
        request.setCharacterEncoding("UTF-8");
        String includedTypes = request.getParameter("includedTypes");
        String[] excludedTypes = request.getParameterValues("excludedTypes");
        int maxResultCount = Integer.parseInt(request.getParameter("maxResultCount"));
        double centerLatitude = Double.parseDouble(request.getParameter("centerLatitude"));
        double centerLongitude = Double.parseDouble(request.getParameter("centerLongitude"));
        double radius = Double.parseDouble(request.getParameter("radius"));
        String rankPreference = request.getParameter("rankPreference");
        String[] additionalReturns = request.getParameterValues("additionalReturns");
        String requestBody = buildRequestJson(includedTypes, excludedTypes, maxResultCount,
            centerLatitude, centerLongitude, radius, rankPreference);
        URL url = new URL(PlacesConfig.API_BASE_URL + PlacesConfig.REQUEST_API);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("X-Goog-Api-Key", PlacesConfig.API_KEY);
        String fieldMask = buildFieldMask(additionalReturns);
        conn.setRequestProperty("X-Goog-FieldMask", fieldMask);
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
        SQLConversionService sqlService = new SQLConversionService(result.toString());
        String sqlOutput = sqlService.insert();
        session.setAttribute("sqlOutput", sqlOutput);
        response.sendRedirect("sql_output.jsp");
    }

    private String buildRequestJson(String includedTypes, String[] excludedTypes, int maxResultCount,
        double centerLatitude, double centerLongitude, double radius, String rankPreference) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"languageCode\":").append("\"zh-TW\"").append(",");
        json.append("\"includedTypes\":[\"").append(includedTypes).append("\"],");
        json.append("\"excludedTypes\":[");
        for (int i = 0; i < excludedTypes.length; i++) {
            json.append("\"").append(excludedTypes[i]).append("\"");
            if (i < excludedTypes.length - 1) {
                json.append(",");
            }
        }
        json.append("],");
        json.append("\"maxResultCount\":").append(maxResultCount).append(",");
        json.append("\"rankPreference\":").append("\"").append(rankPreference).append("\"").append(",");
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

    private String buildFieldMask(String[] additionalReturns) {
        StringBuilder fieldMask = new StringBuilder("places.displayName");
        if (additionalReturns != null) {
            for(int i = 0; i < additionalReturns.length; i++){
                fieldMask.append(",").append(additionalReturns[i]);
            }
        }
        return fieldMask.toString();
    }
}
