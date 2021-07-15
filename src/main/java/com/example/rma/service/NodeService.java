package com.example.rma.service;

import com.example.rma.domain.Node;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;
import java.util.stream.Collectors;
import org.apache.commons.collections4.ListUtils;

@Service
public class NodeService {

    public List<Node> sortNode(List<Node> nodes, Long nodeId){
        if (nodeId == null)
            nodeId = 0L;
        List<Node> nodeList = new ArrayList<>();
        List<Node> firstN = findList(nodeId, nodes);
        for (Node node : firstN ) {
            Long firstId = node.getNodeId();
            Stack<Long> stack = new Stack<>();
            Long t = firstId;
            while (true){
                Node bNode = find(t, nodes);
                nodeList.add(bNode);
                while (true) { List<Node> buffNodeListPar = findList(t, nodes);
                    if (buffNodeListPar == null || buffNodeListPar.isEmpty())
                        break;
                    nodeList.add(buffNodeListPar.get(0));
                    t = buffNodeListPar.get(0).getNodeId();
                    //записываем отложенные в стэк
                    for (int i = 1; i < buffNodeListPar.size(); i++) {
                        stack.push(buffNodeListPar.get(i).getNodeId());
                    }
                }
                if (stack.size() == 0)
                    break;
                t = stack.pop();
            }
        }
        return nodeList;
    }

    private List<Node> findList(Long id , List<Node> nodes)
    {
        return nodes.stream().filter(n -> id.equals(n.getPid())).collect(Collectors.toList());
    }

    private Node find(Long id , List<Node> nodes)
    {
        return nodes.stream().filter(n -> id.equals(n.getNodeId())).findAny().orElse(new Node());
    }
}
