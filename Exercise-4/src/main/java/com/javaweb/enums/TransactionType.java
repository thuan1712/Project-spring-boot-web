package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum TransactionType {
    CSKH("Chăm Sóc Khách Hàng"),
    DDX("Dẫn Đi Xem");

    private final String name;

    TransactionType(String name) { this.name = name; }

    public static Map<String, String> transactionType()
    {
        Map<String, String> typeCodes = new LinkedHashMap<>();
        for(TransactionType it : TransactionType.values())
        {
            typeCodes.put(it.toString(), it.name);
        }
        return typeCodes;
    }
}
