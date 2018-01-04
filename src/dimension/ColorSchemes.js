WGL.dimension.ColorSchemes = function(){

  var schemes = {};

  schemes['blue'] = [
    8, 28, 90,
    46, 182, 194,
    256, 256, 218
  ];

  schemes['red'] = [
    223, 49, 31,
    169, 136, 228,
    23, 97, 154
  ];

  schemes['fire'] = [
    256, 256, 228,
    253, 154, 41,
    102, 38, 5
  ];

  schemes['icy'] = [
    256, 256, 256,
    120, 187, 236,
    36, 28, 95
  ];

  var schemeSelected = "blue";
  var matrixSelected = schemes[schemeSelected];

  this.setSchemeSelected = function(s) {
    schemeSelected = s;
    matrixSelected = schemes[schemeSelected];
  };

  this.getSchemeSelected = function() {
    return schemeSelected;
  };

  this.setCustomMatrixSelected = function(m) {
    schemeSelected = 'custom';
    matrixSelected = m;
  };

  this.getSchemeMatrixSelected = function() {
    return matrixSelected;
  };

};