var generateImage = function(document, layer, scale) {
    var flattener = MSLayerFlattener.alloc().init();
    var array = MSLayerArray.arrayWithLayer(layer)
    var data = document.immutableDocumentData()
    var impage = data.currentPage()

    log("document" + document);
    log("data" + data);
    log("impage" + impage);
    
    var request = nil;
    if ([layer isKindOfClass:MSSliceLayer]) {
        request = data.exportRequestForArtboardOrSlice(layer);
    } else {
        request = [flattener exportRequestFromLayers:array immutablePage:impage immutableDoc:data];
    }
    request.scale = scale;

    var renderer = [MSExportRendererWithSVGSupport exporterForRequest:request colorSpace:[NSColorSpace sRGBColorSpace]];
    var image = renderer.image()
    return image;
}
