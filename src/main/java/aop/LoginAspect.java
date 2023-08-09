package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import dto.Mem;
import exception.ShopException;

@Component
@Aspect
public class LoginAspect {
	@Before("execution(* controller.*.loginCheck*(..)) && args(.., session)")
	public void loginCheck(HttpSession session) throws Throwable {
		Mem sessionMem = (Mem)session.getAttribute("loginMem");
		if(sessionMem == null) {
			throw new ShopException("로그인이 필요한 서비스입니다.", "/second_prj/mem/login"); 
		} 
	}
	
	@Before("execution(* controller.*.idCheck*(..)) && args(.., mem_id, session)")
	public void idCheck(String mem_id, HttpSession session) throws Throwable {
		Mem sessionMem = (Mem)session.getAttribute("loginMem");
		if(sessionMem == null) {
			throw new ShopException("로그인이 필요한 서비스입니다.", "/second_prj/mem/login"); 
		} else if(!sessionMem.getMem_id().equals(mem_id)) {
			throw new ShopException("본인만 접근 가능합니다.", "/second_prj/");
		}
	}
}
