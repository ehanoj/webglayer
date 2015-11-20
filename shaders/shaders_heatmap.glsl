<script id="heatmap_vShader" type="x-shader/x-vertex">
      attribute vec4 wPoint;  
      attribute vec2 index;
      
      uniform mat4 mapMatrix;
      uniform mat4 rasterMatrix;
      
      uniform float radius;  
     
       
      uniform sampler2D filter;
      uniform float numfilters;
      
      uniform float spIndex;
       
      varying vec4 aPos;  
      varying float selected;
            
      void main() {
		  	  
  		float p_size = radius;
  	    	 
  		vec4 p =  mapMatrix * wPoint;  	
  		  		
  		vec4 rp = rasterMatrix * vec4(index[0],index[1],0.,1.);
  		vec4 fdata = texture2D(filter, vec2(rp[0],rp[1]));  		
  		
  		// if data are selected  
  		if ( fdata[0]>= ( (pow(2.,numfilters)-1.) / 256.)  || numfilters==0.){
  			selected = 1.;
  		
  			gl_Position = p; //vec4(-0.,-2.,0.,0.);    	
			gl_PointSize = p_size;
  			  
  			  /*test if the data are selected without considering spatial index*/	
  		} else if (spIndex !=-1. && (fdata[0]>=  (pow(2.,numfilters) - pow(2., spIndex) - 1. ) / 256.) ){
  			selected = 0.;
  			//gl_Position = vec4(-0.,-2.,0.,0.);    	
			//gl_PointSize = 0.;
			gl_Position = p;//vec4(-0.,-2.,0.,0.);    	
			gl_PointSize = p_size;
  		} else {
  			gl_Position = vec4(-0.,-2.,0.,0.);    	
			gl_PointSize = 0.;
  		
  		}
  		
		
		aPos = wPoint;	
				
 		
      }
    </script>
    
    <script id="heatmap_fShader" type="x-shader/x-fragment">
      precision mediump float;  
 	  varying vec4 aPos;   
	  varying float selected;
 	  uniform float grad;  

   		float length(vec2 a, vec2 b){
        	return sqrt(pow((abs(a[0]-b[0])),2.)+pow((abs(a[1]-b[1])),2.));
      	}
           
      void main() {

      	float dist =  length(gl_PointCoord.xy, vec2(0.5,0.5)); 
      	
   
     	if (dist < 0.5 && dist!=0. ) {     		
     		//gl_FragColor = vec4(1., 1. / pow(0.01+dist*10.,grad),selected, 0.);//col;
     		gl_FragColor = vec4(1., 1. - pow(dist*2.,grad) , selected, 0.);//col;  
     		//gl_FragColor = vec4(1., 0. ,0.,1.);
     	} else {
     		gl_FragColor = vec4(0., 0. ,0.,0.);//col; 
     	}
    	
       //gl_FragColor = vec4(sqrt(pow((abs(gl_PointCoord.xy[0]-0.5)),2.)), 0. ,0.,1.);//col; 
      }
      
   
    </script>