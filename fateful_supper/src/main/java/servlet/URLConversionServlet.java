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

@WebServlet("/to_url")
public class URLConversionServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String key = request.getParameter("key");
        if (!key.equals(PlacesConfig.API_KEY)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "API Key error");
            return;
        }
        request.setCharacterEncoding("UTF-8");
        String requestURL = request.getRequestURL().toString();
        requestURL = requestURL.replace("/to_url", "/search");
        String queryString = request.getQueryString();
        String fullURL = requestURL + "?" + queryString;
        HttpSession session = request.getSession();
        session.setAttribute("requestUrlOut", fullURL);
        response.sendRedirect("url_output.jsp");
    }
}
