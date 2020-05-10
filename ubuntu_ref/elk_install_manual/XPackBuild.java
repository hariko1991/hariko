    package org.elasticsearch.xpack.core;  
      
    import org.elasticsearch.common.io.*;  
    import java.net.*;  
    import org.elasticsearch.common.*;  
    import java.nio.file.*;  
    import java.io.*;  
    import java.util.jar.*;  
      
    public class XPackBuild  
    {  
        public static final XPackBuild CURRENT;  
        private String shortHash;  
        private String date;  
          
        @SuppressForbidden(reason = "looks up path of xpack.jar directly")  
        static Path getElasticsearchCodebase() {  
            final URL url = XPackBuild.class.getProtectionDomain().getCodeSource().getLocation();  
            try {  
                return PathUtils.get(url.toURI());  
            }  
            catch (URISyntaxException bogus) {  
                throw new RuntimeException(bogus);  
            }  
        }  
          
        XPackBuild(final String shortHash, final String date) {  
            this.shortHash = shortHash;  
            this.date = date;  
        }  
          
        public String shortHash() {  
            return this.shortHash;  
        }  
          
        public String date() {  
            return this.date;  
        }  
          
        static {  
            final Path path = getElasticsearchCodebase();  
            String shortHash = null;  
            String date = null;  
            if (path.toString().endsWith(".jar")) {  
                try {  
    //                JarInputStream jar = new JarInputStream(Files.newInputStream(path));  
                    JarFile jar = new JarFile(path.toString());  
                    Manifest manifest = jar.getManifest();  
                    shortHash = manifest.getMainAttributes().getValue("Change");  
                    date = manifest.getMainAttributes().getValue("Build-Date");  
                } catch (IOException e) {  
                    throw new RuntimeException(e);  
                }  
            } else {  
                shortHash = "Unknown";  
                date = "Unknown";  
            }  
            // System.out.println("hash:"+ shortHash);  
            // System.out.println("date:"+ date);  
            CURRENT = new XPackBuild(shortHash, date);  
        }  
    }  