package com.example.rma.controller;

import java.util.List;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.dto.Node;
import com.example.rma.service.NodeService;
import com.example.rma.service.SubdivisionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping
public class NodesController {

    @Autowired
    SubdivisionService subdivisionService;

    @Autowired
    NodeService nodeService;

    @GetMapping("/subdivisionNode/{node}/enterprise/{enterprise}")
    public List<Node> nodes(@PathVariable("enterprise") Enterprise enterprise,
                            @PathVariable("node") Long nodeId)  {

        List<Node> nodeList = getSampleNodeList(enterprise, nodeId);

        System.out.println("nodeList " + nodeList);
        return nodeList;
    }

    private List<Node> getSampleNodeList( Enterprise enterprise, Long nodeId) {

        return nodeService.sortNode( subdivisionService.subdivisionToNode(subdivisionService.findByEnterprise(enterprise)), nodeId);
    }
}