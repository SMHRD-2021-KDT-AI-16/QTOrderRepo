package kr.qtorder.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

public class SMSService implements Command{

	final DefaultMessageService messageService;
	
	public SMSService() {
		// 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
		this.messageService = NurigoApp.INSTANCE.initialize("NCS8WUZKQKJJSQ9M", "OSMTWRONB3ZDIVB17DSUS9NTUSUSEM1W", "https://api.coolsms.co.kr");
	}
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cust_phone = ""; // 고객 번호
		String bus_phone = ""; // 업자 번호
		String waitingTime = "";
		
		Message message = new Message();
            // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom(cust_phone);
        message.setTo(bus_phone);
        message.setText("주문하신 음식이 조리를 시작했습니다. 예상 조리시간은."+waitingTime+"입니다.");

        SingleMessageSentResponse responsemsg = this.messageService.sendOne(new SingleMessageSendingRequest(message));
        System.out.println(responsemsg);
        
        
        return null;
	}
}
