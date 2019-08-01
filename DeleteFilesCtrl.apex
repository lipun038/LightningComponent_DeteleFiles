public without sharing class DeleteFilesCtrl {
    @AuraEnabled
    public static List<FilesWrap> getFiles(string objectId){
        List<FilesWrap> wrapList = new List<FilesWrap>();
    	List<ContentDocumentLink> cdList = [SELECT ContentDocument.Title,ContentDocument.FileType,ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =:objectId];
        for(ContentDocumentLink cd : cdList){
            if(cd.ContentDocument.FileType != 'SNOTE'){
        		wrapList.add(new FilesWrap(cd));
            }
        }
        System.debug('---'+wrapList);
        return wrapList;
    }
    @AuraEnabled
    public static string deleteFiles(string objectId,string contentDocumentId){
    	List<ContentDocumentLink> cdlList = [SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId=:contentDocumentId];
        try{    
        	if(cdlList.size() <= 2){
               delete [SELECT Id FROM ContentDocument WHERE Id = :contentDocumentId];
            }else{
                delete [SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId=:objectId AND ContentDocumentId=:contentDocumentId];    
            }
        }catch(Exception ex){
            return ex.getMessage();
        }
        return 'Success';
    }    
    public class FilesWrap{
        @AuraEnabled public String title;
        @AuraEnabled public String fileType;
        @AuraEnabled public String id;
        
        public FilesWrap(ContentDocumentLink cd){
            title = cd.ContentDocument.Title;
            id = cd.ContentDocumentId;
            fileType = cd.ContentDocument.FileType;
        }
    }
}