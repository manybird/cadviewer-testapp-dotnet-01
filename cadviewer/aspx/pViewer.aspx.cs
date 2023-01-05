using System;
using System.Collections.Generic;
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

        hiddenServerUrl.Value = System.Configuration.ConfigurationManager.AppSettings["ServerUrl"];
        hiddenServerBackEndUrl.Value = System.Configuration.ConfigurationManager.AppSettings["ServerUrl"];

        string fileLocation = System.Configuration.ConfigurationManager.AppSettings["fileLocation"];
        string fileLocationUrl = System.Configuration.ConfigurationManager.AppSettings["fileLocationUrl"];

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