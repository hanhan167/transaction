package com.hansy.transaction.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.hansy.transaction.common.BaseReslt;
import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.constants.UserConstants;
import com.hansy.transaction.common.utils.Config;
import com.hansy.transaction.common.utils.StringUtil;
import com.hansy.transaction.model.bo.LoginUser;
import com.hansy.transaction.model.bo.TUserBaseInfoBo;
import com.hansy.transaction.service.ITBusShoppCartService;
import com.hansy.transaction.service.ITUserBaseInfoService;

@Controller
@RequestMapping(value = "/sys")
public class SystemAction {
	
	//private static Logger log = LoggerFactory.getLogger(SystemAction.class);  
	@Resource
	private ITUserBaseInfoService baseInfoService;
	@Resource
	private ITBusShoppCartService shoppCartService;
	@RequestMapping(value = "/login", method=RequestMethod.GET)
	public ModelAndView login(String custNo,HttpSession session){
		//根据custNo获取用户
		BusinessMap<TUserBaseInfoBo> bMap=baseInfoService.getUser(custNo);
		if (!bMap.getIsSucc()) {
			//log.error(bMap.getMsg());
			return new ModelAndView("error");
		}
		String turnAddress="";
		//根据用户类型判断是供方还是买方
		if (bMap.getInfoBody().getUserType().equals(UserConstants.supplyUser)) {
			turnAddress="applyIndent_tab";
		}else{
			turnAddress="buyerIndent_tab";
		}
		ModelAndView view = new ModelAndView(turnAddress);
		session.setAttribute("custNo", custNo);
		session.setAttribute("userType", bMap.getInfoBody().getUserType());
		return view;
	}
	
	/**
	 * 直接跳转到购物车
	 * @param custNo
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/loginShoopingCar", method=RequestMethod.GET)
	public ModelAndView loginShoopingCar(String custNo,HttpSession session){
		String url=Config.getInstance().getValue("informationUrl");
		url = url.replace("toInformation", "toshoppinglogin");
		return new ModelAndView("redirect:"+url+"?custNo="+custNo);
	}
	@RequestMapping(value = "/loginShoopingCarback", method=RequestMethod.GET)
	public ModelAndView loginShoopingCarback(String custNo,HttpSession session){
		//根据custNo获取用户
		BusinessMap<TUserBaseInfoBo> bMap=baseInfoService.getUser(custNo);
		if (!bMap.getIsSucc()) {
			return new ModelAndView("error");
		}
		session.setAttribute("custNo", custNo);
		if(StringUtil.isEmpty(session.getAttribute("custNo")+"")){
			session.setAttribute("custNo", custNo);
		}
		String turnAddress="buyerIndent_shoppingCar";
		ModelAndView view = new ModelAndView(turnAddress);
		
		return view;
	}
	
	
	
	/**
	 * 判断是供方还是买方
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月20日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/isType")
	@ResponseBody
	public BaseReslt<Object> isType(HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		//根据custNo获取用户
		BusinessMap<TUserBaseInfoBo> bMap=baseInfoService.getUser(custNo);
		Map<String, String> param=new HashMap<String,String>();
		param.put("custNo", custNo);
		Integer count = baseInfoService.getLoginUserOrderCount(param);
		String result="";
		//根据用户类型判断是供方还是买方
		if (bMap.getInfoBody().getUserType().equals(UserConstants.supplyUser)) {
			result="supply";
		}else{
			result="buyer";
		}
		Map<String, Object> map=new HashMap<>();
		int goodsNo = shoppCartService.getGoodsNo(custNo);
		map.put("goodsNo", goodsNo);
		LoginUser user=new LoginUser();
		user.setGradeNo(bMap.getInfoBody().getGradeNo());
		user.setLoginName(bMap.getInfoBody().getUserAlias());
		user.setUserType(result);
		bReslt.setSuccess(true);
		bReslt.setObj(user);
		bReslt.setMsg(count+"");
		bReslt.setMap(map);
		return bReslt;
	}
	
	/**
	 * 跳转个人信息页面
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月21日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toInformation")
	public ModelAndView toInformation(HttpServletRequest request){
		String url=Config.getInstance().getValue("informationUrl");
		String custNo =request.getParameter("custNo");
		/*if(""!=custNo||null!=custNo){
			return new ModelAndView("redirect:"+url+"?custNo="+custNo);
		}*/
		return new ModelAndView("redirect:"+url);
	}
	
	@RequestMapping(value = "loginOut", method=RequestMethod.GET)
	public String loginOut(){
		String notLogin=Config.getInstance().getValue("notLogin");
		 return "redirect:" + notLogin + "sys/loginOut.do";
	}
	@RequestMapping("/toCutter")
	public String toCutter(){
		String cutterUrl=Config.getInstance().getValue("notLogin");
		return "redirect:"+cutterUrl;
	}
	@RequestMapping("/toTech")
	public String toTech(HttpSession session,HttpServletResponse response,HttpServletRequest request){
		String custNo=(String) session.getAttribute("custNo");
		if (custNo==null) {
			PrintWriter out;
			try {
				out = response.getWriter();
				 response.setContentType("text/html;charset=UTF-8");
					String url = "<script type='text/javascript'>alert('登录超时请重新登录!');setTimeout(function(){top.location.href='"+Config.getInstance().getValue("informationUrl")+"'},1000)</script>";
					out.print(url);
					out.flush();
				out.close();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		String techUrl=Config.getInstance().getValue("techUrl");
		return "redirect:"+techUrl+custNo;
	}
}
