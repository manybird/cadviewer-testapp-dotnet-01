using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string p = Request["file"];

        if (string.IsNullOrEmpty(p)) return;

        var f = new FileInfo(p);

        if (!f.Exists)
        {
            Response.Write("file not exists: " + f.FullName);
            Response.End();
        }

        hiddenServerUrl.Value = ConfigurationManager.AppSettings["ServerUrl"];
        hiddenServerBackEndUrl.Value = ConfigurationManager.AppSettings["ServerUrl"];

        string fileLocation = ConfigurationManager.AppSettings["fileLocation"];
        string fileLocationUrl = ConfigurationManager.AppSettings["fileLocationUrl"];

        string mapFrom = ConfigurationManager.AppSettings["EdmsDrawingPathMapFrom"];
        string mapTo = ConfigurationManager.AppSettings["EdmsDrawingPathMapTo"];

        if (mapFrom!=null && mapTo != null)
        {
            mapFrom = mapFrom.ToLower();
            mapTo = mapTo.ToLower();
            string fullName1 = f.FullName.ToLower();           
            if (fullName1.IndexOf(mapFrom) == 0)
            {
                var json1 = fullName1.Replace(mapFrom, mapTo) + ".json";

                

                HiddenRedLineFileJson.Value = json1;
                var jsonF1 = new FileInfo(json1);
                if (jsonF1.Exists)
                {
                    HiddenHasJsonFile.Value = "1";
                }
            }
                
        }



        string newPathRelative = @"tmp01\" + Guid.NewGuid() + @"\" + f.Name;
        string newUrlPathRelative = newPathRelative.Replace(@"\", "/");

        string fileLocationNew = Path.Combine(fileLocation, newPathRelative);

        var fNew = new FileInfo(fileLocationNew);

        if (!fNew.Directory.Exists)
        {
            fNew.Directory.Create();
        }
        else if (fNew.Exists)
        {
            fNew.Delete();
        }

        f.CopyTo(fNew.FullName);

        hiddenFileUrl.Value = fileLocationUrl + newUrlPathRelative;

    }
}