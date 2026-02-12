package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKAnnotationToolType;

public class FlutterZoomVideoSdkAnnotationToolType {

    private static final Map<String, ZoomVideoSDKAnnotationToolType> annotationToolType =
            new HashMap<String, ZoomVideoSDKAnnotationToolType>() {{
                put("ZoomVideoSDKAnnotationToolType_None", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_None);
                put("ZoomVideoSDKAnnotationToolType_Pen", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_Pen);
                put("ZoomVideoSDKAnnotationToolType_HighLighter", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_HighLighter);
                put("ZoomVideoSDKAnnotationToolType_AutoLine", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoLine);
                put("ZoomVideoSDKAnnotationToolType_AutoRectangle", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoRectangle);
                put("ZoomVideoSDKAnnotationToolType_AutoEllipse", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoEllipse);
                put("ZoomVideoSDKAnnotationToolType_AutoArrow", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoArrow);
                put("ZoomVideoSDKAnnotationToolType_AutoRectangleFill", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoRectangleFill);
                put("ZoomVideoSDKAnnotationToolType_AutoEllipseFill", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoEllipseFill);
                put("ZoomVideoSDKAnnotationToolType_SpotLight", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_SpotLight);
                put("ZoomVideoSDKAnnotationToolType_Arrow", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_Arrow);
                put("ZoomVideoSDKAnnotationToolType_Eraser", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_ERASER);
                put("ZoomVideoSDKAnnotationToolType_Picker", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_Picker);
                put("ZoomVideoSDKAnnotationToolType_AutoRectangleSemiFill", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoRectangleSemiFill);
                put("ZoomVideoSDKAnnotationToolType_AutoEllipseSemiFill", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoEllipseSemiFill);
                put("ZoomVideoSDKAnnotationToolType_AutoDoubleArrow", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoDoubleArrow);
                put("ZoomVideoSDKAnnotationToolType_AutoDiamond", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoDiamond);
                put("ZoomVideoSDKAnnotationToolType_AutoStampArrow", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampArrow);
                put("ZoomVideoSDKAnnotationToolType_AutoStampCheck", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampCheck);
                put("ZoomVideoSDKAnnotationToolType_AutoStampX", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampX);
                put("ZoomVideoSDKAnnotationToolType_AutoStampStar", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampStar);
                put("ZoomVideoSDKAnnotationToolType_AutoStampHeart", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampHeart);
                put("ZoomVideoSDKAnnotationToolType_AutoStampQm", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampQm);
                put("ZoomVideoSDKAnnotationToolType_VanishingPen", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingPen);
                put("ZoomVideoSDKAnnotationToolType_VanishingArrow", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingArrow);
                put("ZoomVideoSDKAnnotationToolType_VanishingDoubleArrow", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingDoubleArrow);
                put("ZoomVideoSDKAnnotationToolType_VanishingEllipse", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingEllipse);
                put("ZoomVideoSDKAnnotationToolType_VanishingRectangle", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingRectangle);
                put("ZoomVideoSDKAnnotationToolType_VanishingDiamond", ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingDiamond);
            }};

    public static ZoomVideoSDKAnnotationToolType valueOf(String name) {
        ZoomVideoSDKAnnotationToolType type;
        type = annotationToolType.containsKey(name)? annotationToolType.get(name) : ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_None;
        return type;
    }

    private static final Map<ZoomVideoSDKAnnotationToolType, String> annotationToolString =
            new HashMap<ZoomVideoSDKAnnotationToolType, String>() {{
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_None, "ZoomVideoSDKAnnotationToolType_None");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_Pen, "ZoomVideoSDKAnnotationToolType_Pen");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_HighLighter, "ZoomVideoSDKAnnotationToolType_HighLighter");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoLine, "ZoomVideoSDKAnnotationToolType_AutoLine");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoRectangle, "ZoomVideoSDKAnnotationToolType_AutoRectangle");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoEllipse, "ZoomVideoSDKAnnotationToolType_AutoEllipse");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoArrow, "ZoomVideoSDKAnnotationToolType_AutoArrow");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoRectangleFill, "ZoomVideoSDKAnnotationToolType_AutoRectangleFill");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoEllipseFill, "ZoomVideoSDKAnnotationToolType_AutoEllipseFill");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_SpotLight, "ZoomVideoSDKAnnotationToolType_SpotLight");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_Arrow, "ZoomVideoSDKAnnotationToolType_Arrow");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_ERASER, "ZoomVideoSDKAnnotationToolType_Eraser");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_Picker, "ZoomVideoSDKAnnotationToolType_Picker");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoRectangleSemiFill, "ZoomVideoSDKAnnotationToolType_AutoRectangleSemiFill");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoEllipseSemiFill, "ZoomVideoSDKAnnotationToolType_AutoEllipseSemiFill");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoDoubleArrow, "ZoomVideoSDKAnnotationToolType_AutoDoubleArrow");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoDiamond, "ZoomVideoSDKAnnotationToolType_AutoDiamond");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampArrow, "ZoomVideoSDKAnnotationToolType_AutoStampArrow");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampCheck, "ZoomVideoSDKAnnotationToolType_AutoStampCheck");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampX, "ZoomVideoSDKAnnotationToolType_AutoStampX");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampStar, "ZoomVideoSDKAnnotationToolType_AutoStampStar");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampHeart, "ZoomVideoSDKAnnotationToolType_AutoStampHeart");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_AutoStampQm, "ZoomVideoSDKAnnotationToolType_AutoStampQm");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingPen, "ZoomVideoSDKAnnotationToolType_VanishingPen");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingArrow, "ZoomVideoSDKAnnotationToolType_VanishingArrow");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingDoubleArrow, "ZoomVideoSDKAnnotationToolType_VanishingDoubleArrow");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingEllipse, "ZoomVideoSDKAnnotationToolType_VanishingEllipse");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingRectangle, "ZoomVideoSDKAnnotationToolType_VanishingRectangle");
                put(ZoomVideoSDKAnnotationToolType.ZoomVideoSDKAnnotationToolType_VanishingDiamond, "ZoomVideoSDKAnnotationToolType_VanishingDiamond");
            }};

    public static String stringOf(ZoomVideoSDKAnnotationToolType type) {
        String result;
        result = annotationToolString.containsKey(type)? annotationToolString.get(type) : "ZoomVideoSDKAnnotationToolType_None";
        return result;
    }

}
