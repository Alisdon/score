package com.wlf.system.dao;

import java.util.List;

import com.wlf.common.dao.BaseDao;
import com.wlf.system.entity.base.ResourceEntity;
import com.wlf.system.entity.base.UserEntity;

public interface SystemDao extends BaseDao {
	
	public UserEntity getUserByNameAndPassword(UserEntity user);
	
	public List<ResourceEntity> getTreeMenuResource(UserEntity user);
	
	/**
	 * 根据实体名字获取唯一记录
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public <T> T findUniqueByProperty(Class<T> entityClass,
			String propertyName, Object value);
}
