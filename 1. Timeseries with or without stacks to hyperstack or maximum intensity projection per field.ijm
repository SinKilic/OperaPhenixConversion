input = getDirectory("Input1 directory");
output = getDirectory("Output directory");
list = getFileList(input);
setBatchMode(true);
Date = "YYMMDD";
Rowmin = 4;
Rowmax = 4;
Colmin = 7;
Colmax = 7;
Planes = 5;
Flds = 5;
timepoints = 13;
chan= 3;
MIP = 1;
Rowstop = Rowmax+1;
Colstop = Colmax+1;
pl = Planes+1;
fld = Flds+1;
time = timepoints+1
chanstop = chan + 1
for (r = Rowmin; r<Rowstop; r++) {
	if (r<10) {
		R = "0"+r;
	} else if (r<100) {
		R = r;  
	}
		for (c = Colmin; c<Colstop; c++) {
			if (c<10) {
				C = "0"+c;
			} else if (c<100) {
				C = c;  
			}	
				for (f = 1; f<fld; f++) {
					if (f<10) {
						F = "0"+f;
					} else if (f<100) {
						F = f;  
					}	
						for (p = 1; p<pl; p++) {
							if (p<10) {
								P = "0"+p;
							} else if (f<100) {
								P = p;  
							}
							for (t = 1; t<time; t++) {
								T = t;
								for (k = 1; k<chanstop; k++) {
									K = k;
									for (l = 0; l<list.length; l++) {
										if (startsWith(list[l], "r"+R+"c"+C+"f"+F+"p"+P+"-ch"+K+"sk"+T+"fk")) {
											open(input+list[l]);
										}	
									}										  
								}
							}
						}	
					run("Images to Stack", "name=Stack title=[] use");
					run("Stack to Hyperstack...", "order=xyctz channels="+chan+" slices="+Planes+" frames="+timepoints+" display=Grayscale");
					if (MIP==1) {
						run("Z Project...", "projection=[Max Intensity] all");
					}	
					saveAs("tif", output+Date+"_R"+R+"C"+C+"_fld"+F+".tif");
					close();
				}
		}
}
run("Close All");
setBatchMode(false);