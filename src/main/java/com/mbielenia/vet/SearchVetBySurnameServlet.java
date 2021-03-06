package com.mbielenia.vet;

import com.mbielenia.PGConnector;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import org.json.*;

@WebServlet("/rest/vet/search")
public class SearchVetBySurnameServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject surname = new JSONObject(request.getParameter("surname"));

		PGConnector pgdriver = new PGConnector("127.0.0.1", "veterinaria");

		try {
			String queryString = "select webapi_vet_search_by_surname()";

			ArrayList<HashMap<String, Object>> queryResult = new ArrayList<HashMap<String, Object>>();

			queryResult = pgdriver.executeQuery("mbielenia", "1234", queryString);

			JSONArray resultOutput = null;

			for(HashMap<String, Object> result : queryResult) {
				for(String key : result.keySet()) {
					resultOutput = new JSONArray (String.valueOf(result.get(key)));
				}
			}

			PrintWriter pw = response.getWriter();
			response.setContentType("application/json; charset=UTF-8");
			response.setStatus(HttpServletResponse.SC_OK);
			pw.println("hola");
			pw.println(resultOutput.toString());
		} catch (Exception e) {
			System.out.println("error:" + e);
		}
	}
}
