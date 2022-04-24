public class LinkedinTextShareModel
{
	
    public String author {get;set;}
    public String lifecycleState{get;set;}
    public SpecificContent specificContent{get;set;}
    public Map<String, String> visibility{get;set;}
    
    public LinkedinTextShareModel(String author, String lifecycleState, LinkedinTextShareModel.SpecificContent specificContent, Map<String, String> visibility)
    {
		this.author = author;
        this.lifecycleState = lifecycleState;
        this.specificContent = specificContent;
        this.visibility = visibility;
		        
    }
    
    public class SpecificContent
    {
        ShareContent com_linkedin_ugc_ShareContent{get;set;}
        
    }
    
    public class ShareContent
    {
        String shareMediaCategory{get;set;}
        ShareCommentary shareCommentary{get;set;}
    }
    
    public class ShareCommentary
    {
        String text{get;set;}
        public  ShareCommentary(String text)
        {
            this.text = text;
        }    
    }
/*
    public class Visibility
    {
        public Map<String, String> memberNetworkVisibility = new  Map<String, String>();
        
        public Visibility(String networkVisibility)
        {
            memberNetworkVisibility.put('com.linkedin.ugc.MemberNetworkVisibility',networkVisibility);
        }
    }*/
    
}