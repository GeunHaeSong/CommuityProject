package com.sgh.community.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtil {
	// 파일 업로드
	public static String fileCopy(String fileName, String uploadPath, byte[] bytes) throws Exception {
		UUID uuid = UUID.randomUUID();
		String dirString = makeDir(uploadPath);
		String fileString = dirString + File.separator + uuid + "_" + fileName;
		String filePath = uploadPath + File.separator + fileString;
		File fileTaget = new File(filePath);
		FileCopyUtils.copy(bytes, fileTaget);
		boolean result = isImage(fileName);
		System.out.println("result : " + result);
		if(result == true) { // 확장자가 이미지일 경우만 섬네일 만들기 작업
			makeThumbnail(filePath);
		}
		return fileString; // D:/upload 빠짐
	}

	// 확장자가 이미지인지 아닌지 체크
	public static boolean isImage(String fileName) throws Exception {
		// smile.jpg
		String extName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase(); // jpg, JPG -> JPG
		if (extName.equals("JPG") || extName.equals("GIF") || extName.equals("PNG")) {
			return true;
		}
		return false;
	}
	
	public static void makeThumbnail(String filePath) throws Exception {
		// sm 붙이기
		int lastSlash = filePath.lastIndexOf(File.separator) + 1;
		String front = filePath.substring(0, lastSlash);
		String end = filePath.substring(lastSlash);
		String thumbnailName = front + "sm_" + end;
		
		// 원본 이미지, 기존 이미지 버퍼
		BufferedImage srcImage = ImageIO.read(new File(filePath));
		BufferedImage destImage = Scalr.resize(srcImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		File thumbFile = new File(thumbnailName);
		ImageIO.write(destImage, getFormatName(thumbnailName), thumbFile);
	}
	
	public static String getFormatName(String thumbnailName) throws Exception {
		int lastThumbnail = thumbnailName.lastIndexOf(".") + 1;
		String formatName = thumbnailName.substring(lastThumbnail);
		
		return formatName.toUpperCase();
	}
	
	// 폴더 만들기(날짜를 이용해서 세부 폴더도 만들기)
	public static String makeDir(String uploadPath) throws Exception {
		Calendar cale = Calendar.getInstance();
		int year = cale.get(Calendar.YEAR);
		int month = cale.get(Calendar.MONTH) + 1;
		int date = cale.get(Calendar.DATE);
		String dirString = year + File.separator + month + File.separator + date;
		String dirPath = uploadPath + File.separator + dirString;
		File f = new File(dirPath);
		if(!f.exists()) {
			f.mkdirs();
		}
		return dirString;
	}
}
