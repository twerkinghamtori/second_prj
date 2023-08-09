package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import dto.Manager;
import exception.ShopException;

@Component
@Aspect
public class AdminAspect {

	@Around("execution(* admin.controller.Admin*.admin*(..)) && args(..,session)")	
	public Object adminCheck(ProceedingJoinPoint joinPoint,  HttpSession session) throws Throwable{
		Manager loginManager = (Manager)session.getAttribute("loginManager");
		if(loginManager == null) {
			throw new ShopException("관리자만 접근 가능합니다.",  "/second_prj/admin/login");
		}
		return joinPoint.proceed();
	}
	
	@Around("execution(* admin.controller.Admin*.manager*(..)) && args(..,session)")	
	public Object managerCheck(ProceedingJoinPoint joinPoint,  HttpSession session) throws Throwable{
		Manager loginManager = (Manager)session.getAttribute("loginManager");
		if(loginManager == null) {
			throw new ShopException("관리자만 접근 가능합니다.",  "/second_prj/admin/login");
		}
		String grant = loginManager.getManager_grant();
		if(!grant.equals("총괄")) {
			throw new ShopException("총괄 관리자만 접근 가능합니다.",  "/second_prj/admin/main");
		}
		return joinPoint.proceed();
	}
	
}
