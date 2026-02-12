package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKExportFormat;

public class FlutterZoomVideoSdkExportFormat {

    private static final Map<ZoomVideoSDKExportFormat, String> formatTypeMap =
            new HashMap<ZoomVideoSDKExportFormat, String>() {{
                put(ZoomVideoSDKExportFormat.EXPORT_FORMAT_PDF, "ZoomVideoSDKWhiteboardExport_Format_PDF");
            }};

    private static final Map<String, ZoomVideoSDKExportFormat> formatStringMap =
            new HashMap<String, ZoomVideoSDKExportFormat>() {{
                put("ZoomVideoSDKWhiteboardExport_Format_PDF", ZoomVideoSDKExportFormat.EXPORT_FORMAT_PDF);
            }};

    public static String valueOf(ZoomVideoSDKExportFormat name) {
        if (name == null) return "ZoomVideoSDKWhiteboardExport_Format_PDF";

        String result;
        result = formatTypeMap.getOrDefault(name, "ZoomVideoSDKWhiteboardExport_Format_PDF");
        return result;
    }

    public static ZoomVideoSDKExportFormat typeOf(String formatType) {
        if (formatType == null || formatType.equals("")) return ZoomVideoSDKExportFormat.EXPORT_FORMAT_PDF;

        ZoomVideoSDKExportFormat type;
        type = formatStringMap.getOrDefault(formatType, ZoomVideoSDKExportFormat.EXPORT_FORMAT_PDF);
        return type;
    }
}
