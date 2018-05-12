package com.mbielenia.vet;

import com.mbielenia.PGConnector;

import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import org.json.*;

@WebServlet("/rest/vet/create")
public class CreateVetServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String vet = request.getParameter("vet");

		PGConnector pgdriver = new PGConnector("127.0.0.1", "veterinaria");

		try {
			String queryString = "select webapi_vet_create('" + vet + "')";
			pgdriver.execute("mbielenia", "1234", queryString);
		} catch (Exception e) {
			System.out.println("error:" + e);
		}

		response.sendRedirect("/veterinaria/home.jsp");
	}
}
