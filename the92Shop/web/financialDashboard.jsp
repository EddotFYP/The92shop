<%-- 
    Document   : financialDashboard
    Created on : Jan 25, 2018, 11:00:24 PM
    Author     : Clarey Liow JX
--%>


<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Financial Dashboard</title>
        <script src = "js/2.1.3/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>
         <script src = "js/json2.js"></script>
     
    </head>
    <body>
        <form id="myForm" action="FinancialDbController" method="post">
            <input type="hidden" name="monthData" value="monthData">
            <input type="hidden" name="yearData" value="yearData">

            <div id = "financeDB">
                Filter monthly profits/sales/expenses by:

                <select name="month">
                    <option value="none" >Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                </select>

                <button type="submit" name="submit">Submit</button>
                <br />
                <br />
                <%
                    String error = (String) request.getAttribute("error");
                    String text = (String) request.getAttribute("word");
                           
                    //monthly data based on latest year [2017] profit,sales,expense
                    ArrayList<String> monthlyDefaultProfitsResult = (ArrayList<String>) request.getAttribute("monthlyDefaultProfitsResult");
                    String jsonDefMonthlyProfits = new Gson().toJson(monthlyDefaultProfitsResult);

                    ArrayList<String> monthlyDefaultSalesResult = (ArrayList<String>) request.getAttribute("monthlyDefaultSalesResult");
                    String jsonDefMonthlySales = new Gson().toJson(monthlyDefaultSalesResult);

                    ArrayList<String> monthlyDefaultExpenseResult = (ArrayList<String>) request.getAttribute("monthlyDefaultExpenseResult");
                    String jsonDefMonthlyExpenses = new Gson().toJson(monthlyDefaultExpenseResult);

                    //monthly profits,sales,expense based on dropdown selection
                    ArrayList<String> profitsResult = (ArrayList<String>) request.getAttribute("profitsResult");
                    String jsonMonthlyProfits = new Gson().toJson(profitsResult);

                    ArrayList<String> salesResult = (ArrayList<String>) request.getAttribute("salesResult");
                    String jsonMonthlySales = new Gson().toJson(salesResult);

                    ArrayList<String> expenseResult = (ArrayList<String>) request.getAttribute("expenseResult");
                    String jsonMonthlyExpenses = new Gson().toJson(expenseResult);
                    //out.println(jsonMonthlyExpenses);

                    //yearly profits 
                    ArrayList<Double> yearlyProfits = (ArrayList<Double>) request.getAttribute("yearlyProfitsResult");
                    String jsonYearlyProfits = new Gson().toJson(yearlyProfits);

                    //yearly sales 
                    ArrayList<Double> yearlySales = (ArrayList<Double>) request.getAttribute("yearlySalesResult");
                    String jsonYearlySales = new Gson().toJson(yearlySales);

                    //yearly expense 
                    ArrayList<Double> yearlyExpenses = (ArrayList<Double>) request.getAttribute("yearlyExpensesResult");
                    String jsonYearlyExpenses = new Gson().toJson(yearlyExpenses);
                    
                      
                    if (error != null) {
                    out.println("<p style='color:red'>" + error + "</p>");
                     }
            
                    if (text != null && !text.isEmpty()) {
                        if (!text.equals("none")) {
                            out.println("You have selected: " + text + "<br />");
                        }
                    }else{
                        
                    }
                    
                    if (monthlyDefaultProfitsResult != null && monthlyDefaultExpenseResult != null && monthlyDefaultSalesResult != null 
                            && yearlySales != null && yearlyExpenses != null) {
                %>
                <div>
                    <div id = "monthlyDefProfitsContainer" class="containerDB">
                        <script>
            //straight display latest monthly sales
            var monthlyDefProfits = <%=jsonDefMonthlyProfits%>;
            $(document).ready(function () {

                var title = {
                    text: ''
                };
                var subtitle = {
                    text: ''
                };
                var xAxis = {
                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                };
                var yAxis = {
                    title: {
                        text: 'Profits'
                    },
                    plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                };
                var tooltip = {
                    valueSuffix: 'SGD'
                }

                var series = [{
                        name: 'Monthly Profits 2017',
                        data: JSON.parse("[" + monthlyDefProfits + "]")
                    }
                ];

                var license = {
                    enabled: false
                };

                var json = {};
                json.title = title;
                json.subtitle = subtitle;
                json.xAxis = xAxis;
                json.yAxis = yAxis;
                json.tooltip = tooltip;
                json.series = series;
                json.credits = license;

                $('#monthlyDefProfitsContainer').highcharts(json);
            });

                        </script>
                    </div>
                    <div id = "yearlyProfitsContainer" class="containerDB">
                        <script>
                            //straight display latest yearly profits
                            var yearlyProfits = <%=jsonYearlyProfits%>;
                            $(document).ready(function () {
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: [2016, 2017]
                                };
                                var yAxis = {
                                    title: {
                                        text: 'Profits'
                                    },
                                    min: 0,
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: ''
                                }

                                var series = [{
                                        name: 'Yearly Profits',
                                        data: JSON.parse("[" + yearlyProfits + "]")
                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {};

                                json.title = title;
                                json.subtitle = subtitle;
                                json.xAxis = xAxis;
                                json.yAxis = yAxis;
                                json.tooltip = tooltip;
                                json.series = series;
                                json.credits = license;

                                $('#yearlyProfitsContainer').highcharts(json);
                            });
                        </script>
                    </div>
                </div>
                <div>
                    <div id = "monthlyDefSalesContainer" class="containerDB" >
                        <script>
                            //straight display latest monthly sales
                            var monthlyDefSales = <%=jsonDefMonthlySales%>;
                            $(document).ready(function () {
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                                };
                                var yAxis = {
                                    title: {
                                        text: 'Sales'
                                    },
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: 'SGD'
                                }

                                var series = [{
                                        name: 'Monthly Sales 2017',
                                        data: JSON.parse("[" + monthlyDefSales + "]")
                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {};
                                json.title = title;
                                json.subtitle = subtitle;
                                json.xAxis = xAxis;
                                json.yAxis = yAxis;
                                json.tooltip = tooltip;
                                json.series = series;
                                json.credits = license;

                                $('#monthlyDefSalesContainer').highcharts(json);
                            });

                        </script>
                    </div>

                    <div id = "yearlySalesContainer" class="containerDB" >
                        <script>
                            //straight display latest yearly sales
                            var yearlySales = <%=jsonYearlySales%>;
                            $(document).ready(function () {
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: [2016, 2017]
                                };
                                var yAxis = {
                                    title: {
                                        text: 'Sales'
                                    },
                                    min: 0,
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: ''
                                }

                                var series = [{
                                        name: 'Yearly Sales',
                                        data: JSON.parse("[" + yearlySales + "]")
                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {
                                };
                                json.title = title;
                                json.subtitle = subtitle;
                                json.xAxis = xAxis;
                                json.yAxis = yAxis;
                                json.tooltip = tooltip;
                                json.series = series;
                                json.credits = license;

                                $('#yearlySalesContainer').highcharts(json);
                            });
                        </script>
                    </div>
                </div>
                <div>
                    <div id = "monthlyDefExpensesContainer" class="containerDB" >
                        <script>
                            //straight display latest monthly sales
                            var monthlyDefExpenses = <%=jsonDefMonthlyExpenses%>;
                            $(document).ready(function () {
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                                };
                                var yAxis = {
                                    title: {
                                        text: 'Expenses'
                                    },
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: 'SGD'
                                }

                                var series = [{
                                        name: 'Monthly Expenses 2017',
                                        data: JSON.parse("[" + monthlyDefExpenses + "]")
                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {};
                                json.title = title;
                                json.subtitle = subtitle;
                                json.xAxis = xAxis;
                                json.yAxis = yAxis;
                                json.tooltip = tooltip;
                                json.series = series;
                                json.credits = license;

                                $('#monthlyDefExpensesContainer').highcharts(json);
                            });

                        </script>
                    </div>
                    <div id = "yearlyExpensesContainer" class="containerDB">
                        <script>
                            //straight display latest yearly expenses
                            var yearlyExpenses = <%=jsonYearlyExpenses%>;
                            $(document).ready(function () {
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: [2016, 2017]
                                };
                                var yAxis = {
                                    title: {
                                        text: 'Expenses'
                                    },
                                    min: 0,
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: ''
                                }

                                var series = [{
                                        name: 'Yearly Expenses',
                                        data: JSON.parse("[" + yearlyExpenses + "]")
                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {
                                };
                                json.title = title;
                                json.subtitle = subtitle;
                                json.xAxis = xAxis;
                                json.yAxis = yAxis;
                                json.tooltip = tooltip;
                                json.series = series;
                                json.credits = license;

                                $('#yearlyExpensesContainer').highcharts(json);
                            });
                        </script>
                    </div>
                </div>
                <%}%>
                <%if (profitsResult != null && salesResult != null && expenseResult != null) {%>
                <div id = "monthlyDefProfitsContainer" class="containerDB">
                    <script>
                        //straight display latest monthly sales
                        var monthlyProfits = <%=jsonMonthlyProfits%>;
                        $(document).ready(function () {
                            var title = {
                                text: ''
                            };
                            var subtitle = {
                                text: ''
                            };
                            var xAxis = {
                                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                            };
                            var yAxis = {
                                title: {
                                    text: 'Profits'
                                },
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#808080'
                                    }]
                            };
                            var tooltip = {
                                valueSuffix: 'SGD'
                            }

                            var series = [{
                                    name: 'Monthly Profits',
                                    data: JSON.parse("[" + monthlyProfits + "]")
                                }
                            ];

                            var license = {
                                enabled: false
                            };

                            var json = {};
                            json.title = title;
                            json.subtitle = subtitle;
                            json.xAxis = xAxis;
                            json.yAxis = yAxis;
                            json.tooltip = tooltip;
                            json.series = series;
                            json.credits = license;

                            $('#monthlyDefProfitsContainer').highcharts(json);
                        });

                    </script>
                </div>
                <div id = "monthlyDefSalesContainer" class="containerDB">
                    <script>
                        //straight display latest monthly sales
                        var monthlySales = <%=jsonMonthlySales%>;
                        $(document).ready(function () {
                            var title = {
                                text: ''
                            };
                            var subtitle = {
                                text: ''
                            };
                            var xAxis = {
                                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                            };
                            var yAxis = {
                                title: {
                                    text: 'Sales'
                                },
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#808080'
                                    }]
                            };
                            var tooltip = {
                                valueSuffix: 'SGD'
                            }

                            var series = [{
                                    name: 'Monthly Sales',
                                    data: JSON.parse("[" + monthlySales + "]")
                                }
                            ];

                            var license = {
                                enabled: false
                            };

                            var json = {};
                            json.title = title;
                            json.subtitle = subtitle;
                            json.xAxis = xAxis;
                            json.yAxis = yAxis;
                            json.tooltip = tooltip;
                            json.series = series;
                            json.credits = license;

                            $('#monthlyDefSalesContainer').highcharts(json);
                        });

                    </script>
                </div>
                <div  id = "monthlyDefExpensesContainer" class="containerDB" > 
                    <script>
                        //display monthly expense based on dropdown selection

                        var monthlyExpense = <%=jsonMonthlyExpenses%>;
                        $(document).ready(function () {
                            var title = {
                                text: ''
                            };
                            var subtitle = {
                                text: ''
                            };
                            var xAxis = {
                                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                            };
                            var yAxis = {
                                title: {
                                    text: 'Expenses'
                                },
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#808080'
                                    }]
                            };
                            var tooltip = {
                                valueSuffix: 'SGD'
                            }

                            var series = [{
                                    name: 'Monthly Expenses',
                                    data: JSON.parse("[" + monthlyExpense + "]")
                                }
                            ];

                            var license = {
                                enabled: false
                            };

                            var json = {};
                            json.title = title;
                            json.subtitle = subtitle;
                            json.xAxis = xAxis;
                            json.yAxis = yAxis;
                            json.tooltip = tooltip;
                            json.series = series;
                            json.credits = license;

                            $('#monthlyDefExpensesContainer').highcharts(json);
                        });

                    </script>
                </div>
                <%}%>
            </div>
          
        </form>
    </body>
</html>
