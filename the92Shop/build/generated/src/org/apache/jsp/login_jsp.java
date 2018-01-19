package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <script src=\"js/jquery.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("        <script src=\"js/bootstrap.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("        <title>Login Page</title>\r\n");
      out.write("    </head>\r\n");
      out.write("    <body bgcolor=\"#E6E6FA\">\r\n");
      out.write("\r\n");
      out.write("        <div class=\"container\" >\r\n");
      out.write("            <div ng-view class=\"col-sm-12\" style=\"width: 600px; margin-left: 300px; margin-top: 125px;\">\r\n");
      out.write("                <div class=\"jumbotron\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    <div ng-view class=\"form-group\">\r\n");
      out.write("                        <h3 class=\"form-signin-heading\"style=\"margin-left: 10px\">Welcome To The 92 Shop Inventory Management System</h3>\r\n");
      out.write("                    </div>\r\n");
      out.write("\r\n");
      out.write("                    <form ng-view class=\"form-horizontal\" style=\"margin-left: 100px\" action=\"LoginController\" onsubmit=\"return validation()\" method=\"post\">\r\n");
      out.write("                        <div class=\"form-group input-group\">\r\n");
      out.write("                            <span class=\"input-group-addon\">\r\n");
      out.write("                                <span class=\"glyphicon glyphicon-user\">\r\n");
      out.write("\r\n");
      out.write("                                </span>\r\n");
      out.write("                            </span>\r\n");
      out.write("\r\n");
      out.write("                            <input type=\"text\" name=\"username\" id=\"username\" class=\"form-control\" placeholder=\"username\"  style=\"width: 300px;\" required autofocus /><br />\r\n");
      out.write("\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div ng-view class=\"form-group input-group\">\r\n");
      out.write("                            <span class=\"input-group-addon\">\r\n");
      out.write("                                <span class=\"glyphicon glyphicon-lock\">\r\n");
      out.write("\r\n");
      out.write("                                </span>\r\n");
      out.write("                            </span>\r\n");
      out.write("\r\n");
      out.write("                            <input type=\"password\" name=\"password\" id=\"password\" class=\"form-control\" placeholder=\"password\" style=\"width: 300px;\" required  /><br/>\r\n");
      out.write("\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div ng-view class=\"form-group \">\r\n");
      out.write("                            <input type=\"submit\" class=\"btn btn-primary\" value=\"submit\" ><br>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div ng-view class=\"form-group \">\r\n");
      out.write("\r\n");
      out.write("                            <label id =\"warning\"> \r\n");
      out.write("\r\n");
      out.write("                                ");

                                    String error = request.getParameter("error");
                                    if (error != null) {

                                        out.print(error);
                                    }

                                
      out.write("</label>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </form>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
