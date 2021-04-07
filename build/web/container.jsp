<%-- 
    Document   : container
    Created on : 06/04/2021, 21:45:03
    Author     : Vinic
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="t2s.Container" %>

<%
    if(request.getParameter("container")!= null) {
        String container = request.getParameter("container");
        String client = request.getParameter("client");
        int type = Integer.parseInt(request.getParameter("type"));
        int status = Integer.parseInt(request.getParameter("status"));
        int category = Integer.parseInt(request.getParameter("category"));
        
        Container.insert(container, client, type, status, category);
    }
    
    if (request.getParameter("id")!= null) {
        Container.delete(request.getParameter("id"));
    }

%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Containers</title>
    </head>
    <body>
        <div class="ui container">
            <%@include file="WEB-INF/jspf/menu.jspf" %>
            <div class="ui grid">
                <div class="eight wide column">
                    <div class="ui segment">
                        <form class="ui form" method="POST">
                            <h4 class="ui dividing header"> Adicionar Container </h4>
                            <div class="field">
                                <div class="two fields">
                                    <div class="field">
                                        <label>Container</label>
                                        <input type="text" name="container" pattern="[A-Z]{4}[0-9]{7}" title="TEST1234567" placeholder="TEST1234567" required>
                                    </div>
                                    <div class="field">
                                        <label>Cliente</label>
                                        <input type="text" name="client" required>
                                    </div>
                                </div>
                            </div>
                            <div class="field">
                                <div class="three fields">
                                    <div class="field">
                                        <label>Tipo</label>
                                        <select name="type">
                                            <option value="1">20</option>
                                            <option value="2">40</option>
                                        </select>
                                    </div>
                                    <div class="field">
                                        <label>Status</label>
                                        <select name="status">
                                            <option value="1">Cheio</option>
                                            <option value="2">Vazio</option>
                                        </select>
                                    </div>
                                    <div class="field">
                                        <label>Categoria</label>
                                        <select name="category">
                                            <option value="1">Importação</option>
                                            <option value="2">Exportação</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <input class="ui button" type="submit">
                        </form>
                    </div>
                </div>
                <div class="eight wide column">
                    <table class="ui celled table">
                        <thead>
                            <tr>
                                <th>Container</th>
                                <th>Cliente</th>
                                <th>Tipo</th>
                                <th>Status</th>
                                <th>Categoria</th>
                                <th>Ação</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for( Container c: Container.getList()){%>
                                <tr>
                                    <td><%= c.container %></td>
                                    <td><%= c.client %></td>
                                    <td><%= c.type == 1 ? "20" : "40" %></td>
                                    <td><%= c.type == 1 ? "Cheio" : "Vazio"  %></td>
                                    <td><%= c.type == 1 ? "Importação" : "Exportação" %></td>
                                    <td>
                                        <form method="POST">
                                            <input type="hidden" name="id" value="<%= c.container %>">
                                            <input type="submit" value="Excluir" class="ui button basic">
                                        </form>
                                    </td>
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
    </body>
</html>
