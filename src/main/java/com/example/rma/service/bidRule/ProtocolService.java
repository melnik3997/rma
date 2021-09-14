package com.example.rma.service.bidRule;

import com.example.rma.domain.bidRule.Protocol;
import com.example.rma.repository.bidRule.ProtocolRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProtocolService {

    @Autowired
    private ProtocolRepo protocolRepo;

    public Protocol save(Protocol protocol){
        return protocolRepo.save(protocol);
    }
}