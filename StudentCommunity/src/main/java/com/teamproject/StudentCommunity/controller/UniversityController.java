package com.teamproject.StudentCommunity.controller;


import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.PostSearch;
import com.teamproject.StudentCommunity.service.BoardService;
import com.teamproject.StudentCommunity.service.CourseRatingService;
import com.teamproject.StudentCommunity.service.PostService;
import com.teamproject.StudentCommunity.service.UniversityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@RequiredArgsConstructor
@RequestMapping("/university")
@Slf4j
@Controller
public class UniversityController {

    private final BoardService boardService;
    private final PostService postService;
    private final UniversityService universityService;
    private final CourseRatingService courseRatingService;

    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;


    @GetMapping("/{universityId}")
    public String movehome(HttpSession session,@PathVariable Long universityId,
                           Model model) {

        PostSearch postSearch = new PostSearch();
        postSearch.setLimit(5);
        List<PostMemberDTO> postList = new ArrayList<>();
        List<BoardCategoryDto> popularBoard = boardService.findPopularBoard(universityId);


        for(BoardCategoryDto b : popularBoard) {
            postSearch.setBoardId(b.getId());
            postList.addAll(postService.getByPostSearch(postSearch));
        }

        model.addAttribute("courseRating",courseRatingService.getNew(universityId));
        model.addAttribute("popularBoard",popularBoard);
        model.addAttribute("postList",postList);
        model.addAttribute("today", LocalDateTime.now());
        model.addAttribute("popular",postService.getPopularPosts(universityId));

        List<BoardCategoryDto> boardList = boardService.findWithCategoryByUniversityId(universityId);//session
        session.removeAttribute("universityName");
        session.setAttribute("universityName",universityService.getUniversityNameByID(universityId));
        log.info(universityService.getUniversityNameByID(universityId));
        session.removeAttribute("boardList");
        session.setAttribute("boardList",boardList);
        loginMemberDTO.setBoardList(boardList);

        return "home";
    }

    @GetMapping("/uniAutoSearch")
    @ResponseBody
    public List<UniversityDTO> getAllUniName(){





    	return universityService.getAll();
    }



}
