package com.teamproject.StudentCommunity.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.RowColumnTimeTableDTO;
import com.teamproject.StudentCommunity.dto.SubjectTimeTableDTO;
import com.teamproject.StudentCommunity.dto.TimeTableDTO;
import com.teamproject.StudentCommunity.mapper.TimeTableDAO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
@Transactional
public class TimeTableService {

	private TimeTableDAO timeTableDAO;

	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;

	public Long getTimeTableID(TimeTableDTO timeTableDTO) {
		timeTableDTO.setMember_id(loginMemberDTO.getId());
		return timeTableDAO.getTimeTableID(timeTableDTO);
	}

	public List<SubjectTimeTableDTO> getSubjectList(Long timetable_id){
		return timeTableDAO.getSubjectList(timetable_id);
	}

	public List<String> getTimeList(Long id){
		return timeTableDAO.getTimeList(id);
	}

	public void insertSubjectTable(SubjectTimeTableDTO subjectTimeTableDTO){
		timeTableDAO.insertSubjectTable(subjectTimeTableDTO);
	}

	public void insertRcTable(RowColumnTimeTableDTO rowColumn){
		timeTableDAO.insertRcTable(rowColumn);
	}

	public void insertTimetable(TimeTableDTO timeTableDTO){
		timeTableDTO.setMember_id(loginMemberDTO.getId());
		timeTableDAO.insertTimetable(timeTableDTO);
	}

	public void deleteSubjectTableByTimeTableID(Long timetable_id) {
		timeTableDAO.deleteSubjectTableByTimeTableID(timetable_id);
	}
}