package com.teamproject.StudentCommunity.controller;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequiredArgsConstructor
@RequestMapping("/foodMap")
public class FoodMapController {

    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;

    @GetMapping("/search")
    public String Search(Model model){

        model.addAttribute("universityName",loginMemberDTO.getUniversityName());

        return "/foodMap/foodSearch";
    }
}
