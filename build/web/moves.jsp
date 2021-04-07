<%-- 
    Document   : container
    Created on : 06/04/2021, 21:45:03
    Author     : Vinic
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="t2s.Moves" %>
<%@page import="t2s.Container" %>

<%
    if(request.getParameter("container")!= null) {
        String container = request.getParameter("container");
        int moveType = Integer.parseInt(request.getParameter("moveType"));
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        
        Moves.insert(container, moveType, start, end);
    }
    
    if (request.getParameter("id")!= null) {
        Long id = Long.parseLong(request.getParameter("id"));
        Moves.delete(id);
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
                            <h4 class="ui dividing header"> Adicionar Movimentação </h4>
                            <div class="field">
                                <div class="two fields">
                                    <div class="field">
                                        <label>Container</label>
                                        <select name="container">
                                            <%for(Container c: Container.getList()){%>
                                            <option value="<%= c.container%>"><%= c.container%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="field">
                                        <label>Tipo de Movimentação</label>
                                        <select name="moveType">
                                            <option value="1">Embarque</option>
                                            <option value="2">Descarga</option>
                                            <option value="3">Gate In</option>
                                            <option value="4">Gate Out</option>
                                            <option value="5">Posicionamento</option>
                                            <option value="6">Pilha</option>
                                            <option value="7">Pesagem</option>
                                            <option value="8">Scanner</option>
                                        </select>    
                                    </div>
                                </div>
                            </div>
                            <div class="field">
                                <div class="two fields">
                                    <div class="field">
                                        <label>Data de Início</label>
                                        <input type="datetime-local" name="start">
     
                                    </div>
                                    <div class="field">
                                        <label>Data de Término</label>
                                        <input type="datetime-local" name="end">
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
                                <th>Tipo de Movimentação</th>
                                <th>Data de Início </th>
                                <th>Data de Término</th>
                                <th>Ação</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for( Moves v: Moves.getList()){%>
                                <tr>
                                    <td><%= v.container %></td>
                                    <td><%= v.moveType == 1 ? "Embarque" : v.moveType == 2 ? "Descarga" : v.moveType == 3 ? "Gate In" : v.moveType == 4 ? "Gate Out" : v.moveType == 5 ? "Posicionamento" : v.moveType == 6 ? "Pilha" : v.moveType == 7 ? "Pesagem" : "Scanner" %></td>
                                    <td><%= v.start %></td>
                                    <td><%= v.end  %></td>
                                    <td>
                                        <form method="POST">
                                            <input type="hidden" name="id" value="<%= v.rowid %>">
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
