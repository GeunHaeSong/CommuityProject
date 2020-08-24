package com.sgh.community.util;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;

import com.sgh.community.domain.EmailDto;

public class EmailUtil {

	// 회원가입시 이메일 보낼때 필요한 내용 담기
	public static EmailDto joinEmailForm(String to) throws Exception {
		int authentication_number = (int)(Math.random() * 899999) + 100000;
		String subject = "Cyrus 커뮤니티 사이트에서 요청된 인증 메일 입니다.";
		String contents = "회원가입을 진행해주셔서 감사합니다. 회원가입에 필요한 인증 번호 입니다.";
		contents += "\n\n인증 번호는 " + authentication_number + " 입니다.";
		
		EmailDto emailDto = new EmailDto();
		emailDto.setTo(to);
		emailDto.setSubject(subject);
		emailDto.setContents(contents);
		return emailDto;
	}
	
	// 아이디 찾기시 이메일 보낼때 필요한 내용 담기
	public static EmailDto idFindEmailForm(String member_id, String to) throws Exception {
		String subject = "Cyrus 커뮤니티 사이트에서 요청된 인증 메일 입니다.";
		String contents = "아이디 찾기를 진행해주셔서 감사합니다.";
		contents += "\n\n사용자님의 아이디는  " + member_id + " 입니다.";
		
		EmailDto emailDto = new EmailDto();
		emailDto.setTo(to);
		emailDto.setSubject(subject);
		emailDto.setContents(contents);
		return emailDto;
	}
	
	// 이메일 보내기
	public static void emailSubmit(EmailDto emailDto, JavaMailSender mailSender) throws Exception {
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
				helper.setFrom(emailDto.getFrom());
				helper.setTo(emailDto.getTo());
				helper.setSubject(emailDto.getSubject());
				helper.setText(emailDto.getContents());
			}
		};
		mailSender.send(preparator);
	}
}
