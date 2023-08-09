package admin.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminManageService;
import dto.Cs;
import exception.ShopException;

@Controller
@RequestMapping("admin/cs")
public class AdminCsController {

	@Autowired
	private AdminManageService service;

	@RequestMapping("csList")
	public ModelAndView adminCsList(Integer pageNum, String sd, String ed, String query, String cs_state, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (sd == null || sd.equals("")) {
			sd = "";
		}
		if (ed == null || ed.equals("")) {
			ed="";
		}
		if (query == null || query.equals("")) {
			query="";
		}
		if (cs_state == null || cs_state.equals("")) {
			cs_state="";
		}

		int csCnt = service.csCnt(sd, ed, query, cs_state);

		int limit = 10;
		int maxPage = (int)((double)csCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;

		List<Cs> csList =service.getCsList(pageNum, sd, ed, query, cs_state);

		mv.addObject("csList", csList);
		mv.addObject("csCnt", csCnt);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		mv.addObject("sd", sd);
		mv.addObject("ed", ed);
		mv.addObject("cs_state", cs_state);
		return mv;
	}

	@GetMapping({"csRe", "csDetail"})
	public ModelAndView adminCsRe(Integer cs_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Cs cs = service.getCs(cs_number);
		if(cs == null) {
			throw new ShopException("해당 문의는 존재하지 않습니다.", "csList");
		}
		mv.addObject("cs",cs);
		return mv;
	}

	@PostMapping("csRe")
	public ModelAndView adminCsRe(Cs cs, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.csReply(cs)) {
			mv.setViewName("redirect:csDetail?cs_number="+cs.getCs_number());

			// 발신자 정보
			String sender = "zxc2289@naver.com";
			String password = "slfflflakaqh";
			// 메일 받을 주소
			String recipient = cs.getMem_id();
			Properties prop = new Properties();
			try {
				InputStream fis = request.getServletContext().getResourceAsStream("/WEB-INF/classes/mail.properties");
				prop.load(fis);
				prop.put("mail.smtp.user", sender);
			} catch (IOException e) {
				e.printStackTrace();
			}
			Session ses = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(sender, password);
				}
			});
			MimeMessage msg = new MimeMessage(ses);
			// email 전송
			try {
				try {
					msg.setFrom(new InternetAddress(sender, "HOMIEGYM", "UTF-8"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

				msg.setSubject("호미짐에서 문의하신 내용의 답변이 등록 되었습니다.");
				String content = "<a href=\"http://14.36.141.71:10062/second_prj/cs\">답변 확인하기</a><br><br>처리 담당자: " + cs.getManager_name();
				msg.setContent(content, "text/html; charset=UTF-8");
				Transport.send(msg);

			} catch (AddressException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			return mv;
		}else {
			throw new ShopException("문의 답변 등록 실패", "csRe?cs_number="+cs.getCs_number());
		}
	}

	@PostMapping("csDel")
	public ModelAndView managerCsDel(Integer cs_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.csDel(cs_number)) {
			mv.setViewName("redirect:csList");
			return mv;
		}else {
			throw new ShopException("문의 삭제 실패", "csDetail?cs_number="+cs_number);
		}
	}
}
