package com.wlf.system.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wlf.common.controller.BaseController;
import com.wlf.common.util.AjaxJson;
import com.wlf.common.util.ContextHolderUtils;
import com.wlf.common.util.Pagination;
import com.wlf.common.util.ResourceUtil;
import com.wlf.system.entity.base.ResourceEntity;
import com.wlf.system.manager.ClientManager;
import com.wlf.system.service.SystemService;
import com.wlf.system.vo.Client;
import com.wlf.system.vo.TreeNode;

import javassist.expr.NewArray;

@Controller
@RequestMapping("/resourceController")
public class ResourceController extends BaseController{

	private static final Logger logger = Logger.getLogger(ResourceController.class);
	
	@Autowired
	private SystemService systemService;
	
	
	/**
	 * 登陆页
	 * @param error
	 * @param model
	 * @return
	 */
	@RequestMapping(params="goResource")
    public ModelAndView goResource(HttpServletRequest request){
		Client client = ResourceUtil.getClient();
		List<ResourceEntity> resourceList = new ArrayList<ResourceEntity>();
		if(client == null || client.getUser() == null){
			return new ModelAndView("system/login");
		}else{
			resourceList = client.getMenuList();
		}	
		
		List<String> ch=new ArrayList<String>();
		if(resourceList!=null&&!resourceList.isEmpty()&&resourceList.get(0).getResourceType() == ResourceEntity.TYPE_MENU){
			for(ResourceEntity rr:resourceList){
				String code=rr.getCode();
				ch.add(code);
			}
		}
		request.setAttribute("code", ch);
        return new ModelAndView("system/resource");
    }
	
	@RequestMapping(params="save")
    @ResponseBody
	public AjaxJson save(HttpServletRequest request, HttpServletResponse response, ResourceEntity resource,String parentid) throws Exception {
		AjaxJson j = new AjaxJson();
		j.setMsg("保存成功！");
		j.setSuccess(true);
		try{
			ResourceEntity patentRes = new ResourceEntity();
			patentRes.setId(parentid);
			resource.setParentResource(patentRes);
			this.systemService.save(resource);
		}catch(Exception e){
			j.setMsg("保存失败！");
			j.setSuccess(false);
		}
		 return j;
		
	}
	
	@RequestMapping(params="update")
    @ResponseBody
	public AjaxJson update(HttpServletRequest request, HttpServletResponse response, ResourceEntity resource, String parentid) throws Exception {
		AjaxJson j = new AjaxJson();
		j.setMsg("更新成功！");
		j.setSuccess(true);
		try{
			ResourceEntity patentRes = new ResourceEntity();
			patentRes.setId(parentid);
			resource.setParentResource(patentRes);
			this.systemService.update(resource);
		}catch(Exception e){
			j.setMsg("更新失败！");
			j.setSuccess(false);
		}
		 return j;
		
	}
	
	@RequestMapping(params="delete",method=RequestMethod.POST)
    @ResponseBody
	public AjaxJson delete(HttpServletRequest request, HttpServletResponse response, String ids) throws Exception {
		AjaxJson j = new AjaxJson();
		j.setMsg("删除成功！");
		j.setSuccess(true);
		try{
			for(String id:ids.split(",")){
				ResourceEntity resource = new ResourceEntity();
				resource.setId(id);
				this.systemService.delete(resource);
			}
		}catch(Exception e){
			j.setMsg("删除失败！");
			j.setSuccess(false);
		}
		 return j;
		
	}
	
	@RequestMapping(params="datagrid")
    @ResponseBody
	public void datagrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String page = request.getParameter("page");//easyui datagrid 分页 页号
		String rows = request.getParameter("rows");//easyui datagrid 分页 页数
		if(page == null){
			page = "0";
		}
		if(rows == null){
			rows = "0";
		}
		DetachedCriteria condition = DetachedCriteria.forClass(ResourceEntity.class);
		Pagination<?> pagination = systemService.getPageData(condition,Integer.parseInt(page), Integer.parseInt(rows));
		List<ResourceEntity> list= (List<ResourceEntity>)pagination.getDatas();
		String resourceJson = systemService.getTreeJson(list);

        response.setCharacterEncoding("utf-8");//指定为utf-8  
        response.getWriter().write(resourceJson);//转化为JSOn格式  
		
	}
	
	@RequestMapping(params="treeDropdown")
    @ResponseBody
	public void treeDropdown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		if(page == null){
			page = "0";
		}
		if(rows == null){
			rows = "0";
		}
		DetachedCriteria condition = DetachedCriteria.forClass(ResourceEntity.class);
		Pagination<?> pagination = systemService.getPageData(condition,Integer.parseInt(page), Integer.parseInt(rows));
		List<ResourceEntity> list= (List<ResourceEntity>)pagination.getDatas();
		String retJson = systemService.getTreeJson(list);
		String resourceJson = retJson.replaceAll("\"name\"", "\"text\"");
        response.setCharacterEncoding("utf-8"); 
        response.getWriter().write(resourceJson);  
		
	}
}
