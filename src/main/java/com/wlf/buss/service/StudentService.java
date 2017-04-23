package com.wlf.buss.service;

import org.hibernate.criterion.DetachedCriteria;

import com.wlf.buss.entity.base.StudentEntity;
import com.wlf.common.util.Pagination;
import com.wlf.system.service.SystemService;

public interface StudentService extends SystemService {
	
	/**
	 * 根据传入数据进行查询
	 * @param condition
	 * @param ce
	 * @param page
	 * @param rows
	 * @return
	 */
	public Pagination<StudentEntity> findPageData(DetachedCriteria condition,
			StudentEntity ce, int page, int rows);
}
