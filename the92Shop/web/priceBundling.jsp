<%-- 
    Document   : priceBundle
    Created on : March 17, 2018, 12:06:11 AM
    Author     : Jacquelyn
--%>
<%@page import="entity.PurchaseHistory"%>
<%@page import="DAO.PurchaseHistoryDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.Inventory"%>
<%@page import="DAO.InventoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Price Bundling</title>
    </head>
    <body>
     
        <div class="subPageContent">
            <form class="mui-form" action="PriceBundlingController" method="post">
                    <h1>Bundle Pricing Recommendation</h1>
                    <br />
                    <table id="pricingBundleTable">
                         <div class="mui-select">
                          Month
                        <select name="month" class="required" required>
                            <option value='0' selected>Please select</option>
                            <option value='1'>January</option>
                            <option value='2' >February</option>
                            <option value='3' >March</option>
                            <option value='4' >April</option>
                            <option value='5' >May</option>
                            <option value='6' >June</option>
                            <option value='7' >July</option>
                            <option value='8' >August</option>
                            <option value='9' >September</option>
                            <option value='10' >October</option>
                            <option value='11' >November</option>
                            <option value='12'> December</option>   
                        </select>
                        </div> 
                        
                    <div class="mui-select">
                       Year
                        <select name="year" class="required" required>
                            <option value="none" selected>Please select</option>
                            <option value="2018" >2018</option>
                        </select>
                    </div>
                        
                    <div  class="mui-select" class="required" required>
                        Number of result to display
                        <select name="numResult">
                            <option value='0' selected>Please select</option>
                            <option value='5' >5</option>
                            <option value='10' >10</option>
                            <option value='15' >15</option>
                        </select>
                    </div>    
                       
                     
                            <td>
                              <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa  fa-plus" style="font-size:18px;"> Submit</i></button>
                            </td>
                            
                        
                  
                    
                  </table>     
                   
            </form>
       
        
                <%
                   
                    HashMap<Integer,Integer> topXStockList = (HashMap<Integer,Integer>)request.getAttribute("topXStock");
                    PurchaseHistoryDAO purchaseDao = new PurchaseHistoryDAO();
                    InventoryDAO inventoryDAO = new InventoryDAO();
                    String inventoryName ="";
                    int quantity =0;
                     
                    if(topXStockList !=null && !topXStockList.isEmpty()){                    

                    %>
                
                <%int numResult = (Integer)request.getAttribute("numResult"); %>
                <h3 style="padding-left:30px"> Top <%=numResult%> Selling Sock</h3>    
                <h3 style="padding-right:39px"> Least <%=numResult%> Selling Sock</h3>
                
                <table id="priceBundlingTable" border ="1" style="float: left">
                    <thead>
                        <tr>
                            
                            <th> Product Name </th>
                            <th> Quantity </th>
                        </tr>
                    </thead>
                         <%for(int keyId : topXStockList.keySet()){
                       Inventory i = inventoryDAO.retrieve(keyId);
                       inventoryName = i.getName();
                    //    System.out.println(inventoryName);
                    //    inventoryName = keyId;
                        quantity = topXStockList.get(keyId);

                    %>
                    
                    <tbody>
                        <tr>
                           
                            <td id="iName"><%=inventoryName%></td>
                            
                            <td id="quantity"><%=quantity%></td>
                            
                        </tr>
                        <%
                        }
                            
                        %>
                      
                    </tbody>
                </table>
                    <%
                        
                            }
                        %>
                  <%
                    HashMap<Integer,Integer> lowXStockList = (HashMap<Integer,Integer>)request.getAttribute("lowXStock");
                    purchaseDao = new PurchaseHistoryDAO();
                    inventoryDAO = new InventoryDAO();
                    if(lowXStockList !=null){                    
                     
                   inventoryName ="";
                   quantity =0;
                     
                   %>    
               
               <table id="priceBundlingTable" border ="1" style="float: left">
                    <thead>
                        
                        <tr>
                            <th> Product Name </th>
                            <th> Quantity </th>
                        </tr>
                    </thead>
                    <%for(int keyId : lowXStockList.keySet()){
                        Inventory i = inventoryDAO.retrieve(keyId);
                        inventoryName = i.getName();
                        quantity = lowXStockList.get(keyId);
                        System.out.println(inventoryName);
                        System.out.println(quantity);
                    %>
                    
                    <tbody>
                        <tr>
                            <td id="iName"><%=inventoryName%></td>
                            <td id="quantity"><%=quantity%></td>
                        </tr>
                     <%
                            }
                        %>    
                    </tbody>
                </table>     
                <%
                    
                    }
                    
                %>
                    
 </div>
</body>
</html>
