package com.hansy.transaction.common.Interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.hansy.transaction.common.utils.Config;

public class TransactionInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object arg2) throws Exception {
		String s = req.getRequestURI();
		String requestType = req.getHeader("X-Requested-With"); 
		boolean ajaxReq = requestType != null && "XMLHttpRequest".equals(requestType);
		if(s.indexOf("/sys") >= 0){
			return true;
		}else{
			
			HttpSession session = req.getSession();
			String custNo=(String) session.getAttribute("custNo");
			if(custNo == null || "".endsWith(custNo)){
				if (ajaxReq) {
					resp.setContentType("text/json; charset=utf-8");
					resp.setHeader("Cache-Control", "no-cache"); // 取消浏览器缓存
					PrintWriter out = resp.getWriter();
					JSONObject json = new JSONObject();
					json.put("msg", "登录已超时，请重新登录！");
					json.put("sessionOut", "falsee");
					json.put("uul", Config.getInstance().getValue("informationUrl"));
					out.print(json.toJSONString());
					out.flush();
					out.close();
					return false;
				} else {
					String url=Config.getInstance().getValue("informationUrl");
					resp.sendRedirect(url);
					/*PrintWriter out = resp.getWriter();
					out.print("<script type='text/javascript'>top.location='/login.html'</script>");
					out.close();*/
					return false;
				} 
			}else{
				return true;
			}
		}
		
	}

}
