package com.teamproject.StudentCommunity.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.teamproject.StudentCommunity.dto.RowColumnTimeTableDTO;
import com.teamproject.StudentCommunity.dto.SubjectTimeTableDTO;
import com.teamproject.StudentCommunity.dto.TimeTableDTO;

@Mapper
public interface TimeTableDAO {

	public Long getTimeTableID(TimeTableDTO timeTableDTO);
	public List<SubjectTimeTableDTO> getSubjectList(Long timetable_id);
	public List<String> getTimeList(Long id);

	public void insertSubjectTable(SubjectTimeTableDTO subjectTimeTableDTO);
	public void insertRcTable(RowColumnTimeTableDTO rowColumn);
	public void insertTimetable(TimeTableDTO timeTableDTO);

	public void deleteSubjectTableByTimeTableID(Long timetable_id);
}