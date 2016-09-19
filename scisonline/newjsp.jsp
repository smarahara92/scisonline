<%  String ID ="12MCMT12";
            String batchyear = ID.substring(0,2);
            String stream =ID.substring(4,6);
           // out.println(batchyear+"\t\t\t"+stream);
            String streamName = "20"+batchyear;
            out.println(streamName);
          if(stream.equalsIgnoreCase("MT")){
              stream = "MTech_CS";
          }
          else if(stream.equalsIgnoreCase("MB")){
              stream ="MTech_IT";
          }
          else if(stream.equalsIgnoreCase("MI")){
              stream ="MTech_AI";
          }
          else if(stream.equalsIgnoreCase("MC")){
              stream = "MCA";
          }
          else if(stream.equalsIgnoreCase("ME")){
              stream ="IMTech";
          }
          %>