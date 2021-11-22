package com.example.rma.service;

import com.example.rma.domain.dto.Node;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;
import java.util.stream.Collectors;

@Service
public class NodeService {

    public List<Node> sortNode(List<Node> nodes, Long nodeId){
        if (nodeId == null)
            nodeId = 0L;
        List<Node> nodeList = new ArrayList<>();
        //находим корни дерева
        List<Node> firstN = findList(nodeId, nodes);
        //обрабатываем корни
        for (Node node : firstN ) {
            Long firstId = node.getNodeId();
            Stack<Long> stack = new Stack<>();
            Long t = firstId;
            //обработка ветвей
            while (true){
                Node bNode = find(t, nodes);
                nodeList.add(bNode);
                //обработка ветки
                while (true) {
                    //берем подчиняемые записи
                    List<Node> buffNodeListPar = findList(t, nodes);
                    //если нет выходим
                    if (buffNodeListPar == null || buffNodeListPar.isEmpty())
                        break;
                    //записываем первую в лист
                    nodeList.add(buffNodeListPar.get(0));
                    //берем ее id для поиска ее дочек
                    t = buffNodeListPar.get(0).getNodeId();
                    //записываем оставшиеся в стэк
                    for (int i = 1; i < buffNodeListPar.size(); i++) {
                        stack.push(buffNodeListPar.get(i).getNodeId());
                    }
                }
                //если пусто выходим из обработки
                if (stack.size() == 0)
                    break;
                //берем из стека
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
