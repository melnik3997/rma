package com.example.rma.service.bidRule;

import com.example.rma.domain.bidRule.Protocol;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.bidRule.ProtocolRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;

@Service
public class ProtocolService {

    @Autowired
    private ProtocolRepo protocolRepo;

    public Protocol save(Protocol protocol){
        return protocolRepo.save(protocol);
    }

    public List<Protocol> findByDealObjectId(Long dealObjectId){
        return protocolRepo.findByDealObjectId(dealObjectId);
    }

    public Protocol findLastByDealObjectId(Long dealObjectId){
        List<Protocol> protocolList = findByDealObjectId(dealObjectId);

        if(protocolList == null)
            return null;
        return protocolList.stream().max(Comparator.comparing(Protocol::getId)).orElse(null);

    }

    public void delete(Protocol protocol) throws BusinessException {
        Protocol lastProtocol = findLastByDealObjectId(protocol.getDealObject().getId());

        if(!protocol.getId().equals(lastProtocol.getId()))
            throw new BusinessException("Удалять можно только последний протокол");

        protocolRepo.delete(protocol);

    }
}
