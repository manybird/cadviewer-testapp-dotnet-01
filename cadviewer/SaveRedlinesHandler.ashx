<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.IO;
using System.Text;
using System.Configuration;


public class Handler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {


        if (context.Request.HttpMethod.Equals("GET"))
        {
            DoGet(context);

            //context.Response.Write(" Hello World GET");

        }
        if (context.Request.HttpMethod.Equals("POST"))
        {
            DoPost(context);

            //context.Response.Write(" Hello World POST");
        }

    }


    private void DoPost(HttpContext context)
    {

        context.Response.ContentType = "text/plain";

        string filePath = DecodeUrlString(context.Request["file"]).Trim('/');
        string fileContent = context.Request["file_content"];

        string customContent = context.Request["custom_content"];


        string ServerLocation = ConfigurationManager.AppSettings["ServerLocation"];
        string ServerUrl = ConfigurationManager.AppSettings["ServerUrl"];
        string AppLocation = ConfigurationManager.AppSettings["AppLocation"];

        string localPath = "";
        Exception ex = null;
        string mapFrom = ConfigurationManager.AppSettings["EdmsDrawingPathMapFrom"];

        if (string.IsNullOrEmpty(mapFrom))
        {
            try
            {

                string listtype = context.Request["listtype"].Trim('/');

                if ((listtype.IndexOf("serverfolder") == 0) || (listtype.IndexOf("redline") == 0))
                //            if ( (listtype.IndexOf("serverfolder") == 0) )
                {
                    if (filePath.IndexOf(ServerUrl) == 0)
                    {
                        // do nothing 
                    }
                    else
                        filePath = ServerLocation + filePath;
                }


            }
            catch (Exception Ex)
            {
                Console.WriteLine(Ex.Message);
            }

            if (filePath.IndexOf(ServerUrl) == 0)
            {

                filePath = ServerLocation + filePath.Substring(ServerUrl.Length);

            }
            var folder = filePath.Substring(0, filePath.LastIndexOf("/"));

            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            localPath = filePath;

            try
            {
                localPath = new Uri(filePath).LocalPath;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                ex = e;
            }
        }
        else
        {
            localPath = filePath;
            var f = new FileInfo(localPath);

            if (!f.Directory.Exists) f.Directory.Create();
        }
             

        try
        {

            File.WriteAllText(localPath, fileContent);

        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
            ex = e;
        }

        context.Response.ContentType = "text/plain";

        if (ex != null)
        {
            context.Response.StatusCode = 500;
            context.Response.Write(ex.Message);
            context.Response.Write(ex.StackTrace);
            context.Response.End();
        }

        context.Response.Write("Succes");

        //    context.Response.Write(customContent);


    }


    private void DoGet(HttpContext context)
    {

        string filePath =  DecodeUrlString(context.Request["file"]).Trim('/');
        string fileContent = context.Request["file_content"];

        // we need to create the filePath folder
        //string tmpPrintFolder = HttpContext.Current.Server.MapPath("~\\temp_print");
        //Directory.CreateDirectory(tmpPrintFolder);

        //string absFilePath = Path.Combine(tmpPrintFolder, filePath);

        //context.Response.Write(absFilePath);

        //File.WriteAllText(absFilePath, fileContent);
        File.WriteAllText(filePath, fileContent);

        context.Response.ContentType = "text/plain";
        context.Response.Write("Succes");
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

    private static string DecodeUrlString(string url) {
        string newUrl;
        while ((newUrl = Uri.UnescapeDataString(url)) != url)
            url = newUrl;
        return newUrl;
    }

}