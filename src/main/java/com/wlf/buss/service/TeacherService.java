package com.wlf.buss.service;

import org.hibernate.criterion.DetachedCriteria;

import com.wlf.buss.entity.base.TeacherEntity;
import com.wlf.common.util.Pagination;
import com.wlf.system.service.SystemService;

public interface TeacherService extends SystemService {
	
	/**
	 * 根据传入数据进行查询
	 * @param condition
	 * @param ve
	 * @param page
	 * @param rows
	 * @return
	 */
	public Pagination<TeacherEntity> findPageData(DetachedCriteria condition,
			TeacherEntity ve, int page, int rows);
}
