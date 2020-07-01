package com.VideoKonference.RegexClass;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ExtractRemoveString {
	
	public static String removeStringfromOrg(String Orgstr, String patternStr) {
        String extractedStr = "";
        Pattern pattern = Pattern.compile(patternStr);
        Matcher matcher = pattern.matcher(Orgstr);
        int startIndex = 0, endIndex = 0;
        boolean found = false;
        while (matcher.find()) {
            //System.out.println("I found the text "+matcher.group()+" starting at index " + matcher.start()+" and ending at index "+matcher.end());
            //System.out.println(matcher.group());
            startIndex = matcher.start();
            endIndex = matcher.end();
            found = true;
        }
        if(!found){
            //System.out.println("No match found.");
        }
        extractedStr += Orgstr.substring(0, startIndex) + Orgstr.substring(endIndex);
        return extractedStr;
    }
	
	public static String ExtractToken(String OrgStr, String patternStr) {
        String temp = "";
        Pattern pattern = Pattern.compile(patternStr);
        Matcher matcher = pattern.matcher(OrgStr);
        ArrayList<Integer> startIndex = new ArrayList<>();
        ArrayList<Integer> endIndex = new ArrayList<>();
        boolean found = false;
        while (matcher.find()) {
            //System.out.println("I found the text "+matcher.group()+" starting at index "+ matcher.start()+" and ending at index "+matcher.end());
            //System.out.println(matcher.group());
            startIndex.add(matcher.start());
            endIndex.add(matcher.end());
            found = true;
        }
        for (int i = 0; i < startIndex.size(); i++)
        {
            //System.out.println("startIndex : " + startIndex.get(i) + ", endIndex : " + endIndex.get(i));
        }
        if(!found){
            //System.out.println("No match found.");
        }
        else{
            for(int i = 0; i < startIndex.size() - 1; i++)
            {
                if(startIndex.get(i) != 0 && i == 0)
                    temp += OrgStr.substring(0, startIndex.get(i));
                else
                    temp += OrgStr.substring(endIndex.get(i), startIndex.get(i + 1));

            }
            //System.out.println(temp);
        }
        return temp;
    }

}
