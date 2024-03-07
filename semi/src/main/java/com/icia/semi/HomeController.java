package com.icia.semi;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.semi.dto.SemiDto;
import com.icia.semi.dto.applyDto;
import com.icia.semi.dto.memberDto;
import com.icia.semi.dto.mysellDto;
import com.icia.semi.service.SemiService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	@Autowired
	private SemiService sServ;

	// 구직페이지 메인
	@GetMapping("main")
	public String main(Integer pageNum, Model model, HttpSession session) {
		log.info("main()");

		String view = sServ.getContentList(pageNum, model, session);

		return view;
	}

	// 구직글 등록 페이지
	@GetMapping("jobFrm")
	public String jobFrm() {
		log.info("jobFrm()");

		return "jobFrm";
	}

	// 구직글 등록
	@PostMapping("jobProc")
	public String jobProc(@RequestPart List<MultipartFile> files, SemiDto content, HttpSession session,
			RedirectAttributes rttr) {
		log.info("jobProc()");
		String view = sServ.insertContent(files, content, session, rttr);
		return view;
	}

	// 상세페이지
	@GetMapping("detail")
	public String detail(Integer c_id, Model model) {
		log.info("detail()");
		sServ.getContent(c_id, model);
		return "detail";
	}

	// 수정 페이지 전환
	@GetMapping("updateFrm")
	public String updateFrm(Integer c_id, Model model) {
		log.info("updateFrm()");
		sServ.getContent(c_id, model);
		return "updateFrm";
	}

	// 수정 데이터 처리
	@PostMapping("updateProc")
	public String updateProc(@RequestPart List<MultipartFile> files, SemiDto content, HttpSession session,
			RedirectAttributes rttr) {
		log.info("updateProc()");
		String view = sServ.contentUpdate(files, content, session, rttr);
		return view;
	}

	// 삭제 데이터 처리
	@GetMapping("delete")
	public String deletContent(Integer c_id, HttpSession session, RedirectAttributes rttr) {
		log.info("deleteContent");
		String view = sServ.contentDelete(c_id, session, rttr);
		return view;
	}

	// 첫 화면페이지
	@GetMapping("/")
	public String home() {

		return "home";

	}

	// 로그인 페이지 불러오기
	@GetMapping("login")
	public String login() {

		return "login";

	}

// 로그인 기능
	@PostMapping("login")
	public String processLogin(memberDto member, HttpSession session, RedirectAttributes rttr) {
		log.info("processLogin()");
		String loginSuccess = sServ.authenticate(member, session, rttr);

		return loginSuccess;
	}
	// 로그아웃 기능

	@GetMapping("logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		log.info("logout");
		String view = sServ.logout(session, rttr);
		return view;
	}

	@PostMapping("logout")
	public String processLogout(HttpSession session, RedirectAttributes rttr) {
		log.info("processLogout");
		String logoutSuccess = sServ.logout(session, rttr);
		return logoutSuccess;
	}

	// 회원가입
	@PostMapping("join")
	public String processMemberjoin(memberDto member, RedirectAttributes rttr) {
		log.info("processMemberjoin() : id - {}", member.getM_id());
		String view = sServ.join(member, rttr);

		return view;
	}

	// 회원가입 기능
	@GetMapping("join")
	public String memberjoinForm(Model model) {
		model.addAttribute("member", new memberDto());
		return "join";
	}

	@PostMapping("checkDuplicateId") // 아이디 중복 체크 확인
	@ResponseBody
	public String checkDuplicateId(String m_id) {
		log.info("checkDuplicateId: {}", m_id);
		String res = sServ.checkDuplicateId(m_id);

		return res;
	}

	@GetMapping("mysell")
	public String mysell(Model model, HttpSession session) {
		log.info("mysell()");

		// 1. Check for null session attribute (memberDto)
		memberDto mDto = (memberDto) session.getAttribute("member");
		if (mDto == null) {
			// Handle null memberDto scenario (e.g., redirect to login page)
			return "redirect:/login"; // Or handle differently based on your application logic
		}

		// 2. Check for empty list returned by service
		List<mysellDto> myList = sServ.getMysellByMember(session, model);
		if (myList == null || myList.isEmpty()) {
			// Handle empty list scenario (e.g., display message)
			model.addAttribute("message", "No sales listings found.");
			return "mysell";
		}

		// 3. Access first element safely after checks
		mysellDto myDTO = myList.get(0);
		model.addAttribute("s_id", myDTO.getS_id());
		return "mysell";
	}

	// 회원 이력서 작성 넘겨줌
	@GetMapping("mysellWrite")
	public String write() {
		log.info("write");
		return "mysellWrite";
	}

	// 회원 이력서 작성페이지
	@PostMapping("mysellWrite")
	public String mysellWrite(@RequestPart List<MultipartFile> files, mysellDto myDto, HttpSession session,
			RedirectAttributes rttr) {
		log.info("mysellWrite()");

		String view = sServ.mysellWrite(files, myDto, session, rttr);

		return view;
	}

	// 이력서 수정페이지 이동
	@GetMapping("mysellFrm")
	public String mysellFrm(Integer s_id, Model model) {
		log.info("updateFrm()");

		sServ.getDetail(s_id, model);
		return "mysellFrm";
	}

	// 이력서 수정
	@PostMapping("myUpdate")
	public String myUpdate(@RequestParam List<MultipartFile> files, mysellDto myDto, HttpSession session,
			RedirectAttributes rttr) {
		log.info("myUpdate()");

		String view = sServ.mysellWrite(files, myDto, session, rttr);

		return view;
	}

	@GetMapping("mysellDetail")
	public String mysellDetail(@RequestParam(required = false) Integer s_id, Model model) {

		log.info("mysellDetail()");

		mysellDto myDto = sServ.getDetail(s_id, model);

		if (s_id == null) {
			// s_id가 없는 경우 처리 (예: 메시지 표시)
			model.addAttribute("message", "이력서 정보가 없습니다.");
			
			return "mysellDetail";
		}
		model.addAttribute("myDto", myDto);

		return "mysellDetail";
	}

	// 지원자 목록 보기
	@GetMapping("mysellList")
	public String mysellList(Integer pageNum, Model model, HttpSession session) {
		log.info("mysellList()");

		String view = sServ.getmysellList(pageNum, model, session);

		return view;
	}

	@PostMapping("apply")
	public String apply(applyDto apply, Model model, HttpSession session) {

		log.info("apply()");

		String view = sServ.getapply(apply, model, session);

		return view;
	}

	// 업체 지원자 보기
	@GetMapping("applyList")
	public String applyList(Integer pageNum, Model model, HttpSession session) {
		log.info("applyList()");

		String view = sServ.getapplyList(pageNum, model, session);

		return view;
	}

	@PostMapping("applyList")
	public String postapplyList(mysellDto myDto, HttpSession session, RedirectAttributes rttr, Model model) {
		log.info("postapplyList()");

		String view = sServ.getpostapplyList(myDto, session, rttr, model);

		return view;
	}

}
