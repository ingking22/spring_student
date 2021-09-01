
package com.teamproject.StudentCommunity.service;

import javax.annotation.Resource;

import com.teamproject.StudentCommunity.criteria.Criteria;
import com.teamproject.StudentCommunity.dto.MemberSearchDTO;
import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.mapper.MemberDAO;

import lombok.AllArgsConstructor;

import java.util.List;

@Service
@AllArgsConstructor
@Transactional
public class MemberService {
  
   private UniversityService universityService;
   private MemberDAO memberDAO;
   private SuspendedHistoryService suspendedHistoryService;
   
   @Resource(name = "loginMemberDTO")
   @Lazy
   private MemberDTO loginMemberDTO;
   

   public void memberRegist(MemberDTO memberDTO) {
      
      memberDTO.setEmail(memberDTO.getEmail()+ "@" + memberDTO.getDomain());
      
      memberDAO.memberRegist(memberDTO);
      
   }

   
   public boolean checkUser(String name) {
      
      String check = memberDAO.checkUser(name);
      
      if(check == null) {
         return true;
      }else {
         return false;
      }
      
   }


   public void getLoginUser(MemberDTO memberDTO) {

      MemberDTO fromDBMemberDTO = memberDAO.getLoginUser(memberDTO);


		if(fromDBMemberDTO != null) {
			
			String universityName = universityService.getUniversityNameByID(fromDBMemberDTO.getUniversityId());
			
			System.out.println("universityName : " + universityName);
			
			
			loginMemberDTO.setId(fromDBMemberDTO.getId());
			loginMemberDTO.setPassword(fromDBMemberDTO.getPassword());
			loginMemberDTO.setEmail(fromDBMemberDTO.getEmail());
			loginMemberDTO.setName(fromDBMemberDTO.getName());
			loginMemberDTO.setImg(fromDBMemberDTO.getImg());
			loginMemberDTO.setStatus(fromDBMemberDTO.getStatus());
			loginMemberDTO.setDomain(fromDBMemberDTO.getDomain());
			loginMemberDTO.setUniversityId(fromDBMemberDTO.getUniversityId());
			loginMemberDTO.setUniversityName(universityName);
			loginMemberDTO.setUserLogin(true);
		}

		return;
	}

	public MemberDTO getUserInfo(MemberDTO modifyMemberDTO, MemberDTO checkMemberDTO) {
		
		MemberDTO modifyMemberInfo = memberDAO.getUserInfo(checkMemberDTO);
		
		if(modifyMemberInfo != null) {
			modifyMemberDTO.setId(modifyMemberInfo.getId());
			modifyMemberDTO.setPassword(modifyMemberInfo.getPassword());
		}

		return modifyMemberInfo;
	}
	
	public void updateMemberInfo(MemberDTO modifyMemberDTO) {
		modifyMemberDTO.setId(loginMemberDTO.getId());
		loginMemberDTO.setImg(modifyMemberDTO.getImg());
		memberDAO.updateMemberInfo(modifyMemberDTO);
	}
	
	// 정지회원 스케쥴러로 분석후 ACTIVE로 변환
	@Transactional
	public void changeActive(Long memberId) {
		memberDAO.changeActive(memberId);
		suspendedHistoryService.deleteHistory(memberId);
	}
	
	public boolean checkEmail(String email) {
		String returnEmail = memberDAO.checkEmail(email);
		
		if(returnEmail == null)
			return false;
		else
			return true;
	}
	
	public void deleteMemberInfo(MemberDTO deleteMemberDTO) {
	      deleteMemberDTO.setEmail(loginMemberDTO.getEmail());
	      deleteMemberDTO.setPassword(loginMemberDTO.getPassword());
	      memberDAO.deleteMemberInfo(deleteMemberDTO);
	   }
	
	 public void getUserDel(MemberDTO deleteMemberDTO, MemberDTO checkDelMemberDTO) {
	      
	      MemberDTO deleteMemberInfo = memberDAO.getUserDel(checkDelMemberDTO);
	      
	      	if(deleteMemberInfo != null) {
	      		deleteMemberDTO.setId(deleteMemberInfo.getId());
	         deleteMemberDTO.setPassword(deleteMemberInfo.getPassword());
      }
   }

	public MemberDTO findUserInfoById(Long id) {
		return memberDAO.findUserInfoById(id);
	}
	
	
	public MemberDTO findUniversityNameByID(String universityName) {
		return memberDAO.findUniversityNameByID(universityName);
	}
	

	public void updateImage(MemberDTO pathUpdate) {
		memberDAO.updateImage(pathUpdate);
	}

	public void updatePassword(MemberDTO memberDTO){
   		memberDAO.updatePassword(memberDTO);
	}

	public void updateName(MemberDTO memberDTO){
	    memberDAO.updateName(memberDTO);
	}

	public List<PostMemberDTO> findAllMember(PageDTO pageDTO){
		return memberDAO.findAllMember(pageDTO);
	}

	public int getTotalCountMember(PageDTO pageDTO){
		return memberDAO.getTotalCountMember(pageDTO);
	}


	public void deleteMember(Long id) {
   		memberDAO.deleteMember(id);
	}

	public List<MemberDTO> getMemberNameEmail(){
   	return memberDAO.getMemberNameEmail();
	}
}
