package bbs;

import java.io.IOException;
import java.util.ArrayList;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
/**
 * Servlet implementation class UserSearchServlet
 */
@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String userID = request.getParameter("userID");
        response.getWriter().write(getJSON(userID));
    }
    
    public String getJSON(String userID) {
        if(userID == null) userID="";
        StringBuffer result = new StringBuffer("");    //result��� ���� ����
        result.append("{\"result\":[");        //result�� ���ڿ��� ����
        BbsDAO bbsDAO=new BbsDAO();
        ArrayList<Bbs> bbsList = bbsDAO.search(userID);    //�˻��� userName�� search �޼ҵ忡 �ְ� ���ϰ��� ������
        for(int i=0; i<bbsList.size(); i++) {    //�˻��� �ش�Ǵ� userList�� ���̸�ŭ
            result.append("[{\"value\": \""+bbsList.get(i).getBbsID()+"\"},");    //�ش� user���� ������ result�� ����
            result.append("{\"value\": \""+bbsList.get(i).getBbsTitle()+"\"},");
            result.append("{\"value\": \""+bbsList.get(i).getUserID()+"\"},");
            result.append("{\"value\": \""+bbsList.get(i).getBbsDate()+"\"}],");
        }
        result.append("]}");
        return result.toString();
    }
 
}
