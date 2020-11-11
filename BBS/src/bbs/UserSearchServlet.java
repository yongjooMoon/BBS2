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
        StringBuffer result = new StringBuffer("");    //result라는 변수 생성
        result.append("{\"result\":[");        //result에 문자열을 담음
        BbsDAO bbsDAO=new BbsDAO();
        ArrayList<Bbs> bbsList = bbsDAO.search(userID);    //검색할 userName을 search 메소드에 넣고 리턴값을 저장함
        for(int i=0; i<bbsList.size(); i++) {    //검색에 해당되는 userList의 길이만큼
            result.append("[{\"value\": \""+bbsList.get(i).getBbsID()+"\"},");    //해당 user들의 정보를 result에 넣음
            result.append("{\"value\": \""+bbsList.get(i).getBbsTitle()+"\"},");
            result.append("{\"value\": \""+bbsList.get(i).getUserID()+"\"},");
            result.append("{\"value\": \""+bbsList.get(i).getBbsDate()+"\"}],");
        }
        result.append("]}");
        return result.toString();
    }
 
}
