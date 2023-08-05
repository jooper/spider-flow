package org.spiderflow.controller;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.util.regex.Pattern.compile;

public class t {


    public static List<String> getMatchers(String content,String regx,int groupIndex){
        Matcher matcher = compile(regx).matcher(content);
        List<String> results = new ArrayList<>();
        while(matcher.find()){
            results.add(matcher.group(groupIndex));
        }
        return results;
    }
        public static void main(String[] args) {
            // 给定的字符串
            String data = "本周国内N型料价格区间在7.8-8.5万元/吨，成交均价为8.04万元/吨，周环比涨幅为2.03%";
            String regx="N型料价格区间在(\\d+\\.\\d+-\\d+\\.\\d+)万元/吨，成交均价为(\\d+\\.\\d+)万元/吨，周环比涨幅为(\\d+\\.\\d+)%";

            // 使用正则表达式进行提取
            Pattern pattern = compile(regx);
            Matcher matcher = pattern.matcher(data);

//            List<String> matchers = getMatchers(data, regx, 0);

            int groupCount = matcher.groupCount();

            List<String> results = new ArrayList<>();

            matcher.find();
            String priceRange1 = matcher.group(0);
            results.add(priceRange1);
            matcher.find();
            String priceRange2 = matcher.group(0);
            results.add(priceRange1);
            matcher.find();
            String priceRange3 = matcher.group(0);
            results.add(priceRange1);


            // 输出结果
            if (matcher.find()) {
                String productType = "N型料价格区间";
                String priceRange = matcher.group(1);
                String unit1 = "万元/吨";
                String statIndicator1 = "成交均价";
                String avgPrice = matcher.group(2);
                String unit2 = "万元/吨";
                String statIndicator2 = "周环比涨幅";
                String increase = matcher.group(3);

                System.out.println("产品类型：" + productType);
                System.out.println("价格区间：" + priceRange);
                System.out.println("单位：" + unit1);
                System.out.println("统计指标：" + statIndicator1);
                System.out.println("均价：" + avgPrice);
                System.out.println("单位：" + unit2);
                System.out.println("统计指标：" + statIndicator2);
                System.out.println("涨幅：" + increase);
            } else {
                System.out.println("未找到匹配项");
            }
        }
    }


