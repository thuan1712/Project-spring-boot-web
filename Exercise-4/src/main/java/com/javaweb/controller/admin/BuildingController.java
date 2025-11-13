package com.javaweb.controller.admin;



import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.enums.buildingType;
import com.javaweb.enums.districtCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.BuildingService;
import com.javaweb.service.impl.UserService;
import com.javaweb.utils.DisplayTagUtils;
import org.hibernate.validator.constraints.SafeHtml;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller(value="buildingControllerOfAdmin")
public class BuildingController {

    @Autowired
    private UserService userService ;

    @Autowired
    private BuildingService buildingService ;

//    @GetMapping(value = "/admin/building-list")
//    public ModelAndView buildingList(@ModelAttribute BuildingSearchRequest buildingSearchRequest , HttpServletRequest request) {
//        ModelAndView mav = new ModelAndView("admin/building/list");
//        mav.addObject("modelSearch",buildingSearchRequest);
//        List<BuildingSearchResponse> responseList = buildingService.findAll(buildingSearchRequest);
//        mav.addObject("staffsList", userService.getStaffs());
//        mav.addObject("districts", districtCode.type());
//        mav.addObject("buildingTypes", buildingType.type());
//        mav.addObject("buildingList", responseList);
//        return mav;
//    }

    @GetMapping(value = "/admin/building-list")
    public ModelAndView buildingList(@ModelAttribute BuildingSearchRequest buildingSearchRequest, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/list");
        mav.addObject("modelSearch", buildingSearchRequest);
        mav.addObject("staffsList", userService.getStaffs());
        mav.addObject("districts", districtCode.type());
        mav.addObject("buildingTypes", buildingType.type());
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            Long staffId = SecurityUtils.getPrincipal().getId();
            buildingSearchRequest.setStaffId(staffId);
            mav.addObject("buildings", buildingService.findAll(buildingSearchRequest)); // WHERE userId =
        } else { // Manager
            mav.addObject("buildings", buildingService.findAll(buildingSearchRequest)); // Find All
        }

        BuildingSearchResponse model = new BuildingSearchResponse();
        DisplayTagUtils.of(request, model);

        //List<BuildingSearchResponse> buildingDTOS = buildingService.getAllBuilding(new PageRequest(model.getPage() - 1
        //, model.getMaxPageItems()));
        //model.setListResult(buildingDTOS);
        model.setTotalItems(buildingService.findAll(buildingSearchRequest).size());

        mav.addObject(SystemConstant.MODEL, model);
//        initMessageResponse(mav, request);

        return mav;
    }

    @GetMapping(value = "/admin/building-edit")
    public ModelAndView buildingEdit(@ModelAttribute("buildingEdit") BuildingDTO buildingDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("districts", districtCode.type());
        mav.addObject("buildingTypes", buildingType.type());
        return mav;
    }

    @GetMapping(value = "/admin/building-edit-{id}")
    public ModelAndView buildingEdit(@PathVariable("id") Long id,@ModelAttribute("buildingEdit") BuildingDTO buildingDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        BuildingDTO dto = buildingService.getBuildingDTOById(id);
        mav.addObject("buildingEdit", dto);
        mav.addObject("districts", districtCode.type());
        mav.addObject("buildingTypes", buildingType.type());
        return mav;
    }
}
