const AWS = require('aws-sdk');
const sharp = require('sharp');

const s3 = new AWS.S3();

exports.handler = async (event) => {
  try {
    // Get the bucket and key from the event
    const bucket = event.Records[0].s3.bucket.name;
    const key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));
    
    // Only process files in the 'uploads' folder
    if (!key.startsWith('uploads/')) {
      console.log(`File ${key} is not in the uploads folder, skipping`);
      return;
    }
    
    // Get the image from S3
    const image = await s3.getObject({
      Bucket: bucket,
      Key: key
    }).promise();
    
    // Get environment variables
    const processedBucket = process.env.PROCESSED_BUCKET;
    const imageSizes = JSON.parse(process.env.IMAGE_SIZES);
    const watermarkText = process.env.WATERMARK_TEXT || 'Processed';
    
    // Get the original image name without the 'uploads/' prefix
    const originalName = key.replace('uploads/', '');
    const baseName = originalName.substring(0, originalName.lastIndexOf('.'));
    const extension = originalName.substring(originalName.lastIndexOf('.') + 1);
    
    // Process the image for each size
    const promises = imageSizes.map(async (size) => {
      // Resize the image
      const resizedImage = await sharp(image.Body)
        .resize(size, null, { withoutEnlargement: true })
        .toBuffer();
      
      // Add watermark
      const watermarkedImage = await addWatermark(resizedImage, watermarkText, size);
      
      // Save the processed image to S3
      const processedKey = `processed/${baseName}_${size}px.${extension}`;
      
      await s3.putObject({
        Bucket: processedBucket,
        Key: processedKey,
        Body: watermarkedImage,
        ContentType: image.ContentType
      }).promise();
      
      return processedKey;
    });
    
    // Wait for all processing to complete
    const processedKeys = await Promise.all(promises);
    
    console.log(`Successfully processed image: ${key}`);
    console.log(`Processed images saved to: ${processedKeys.join(', ')}`);
    
    return {
      statusCode: 200,
      body: JSON.stringify({
        message: 'Image processed successfully',
        processedKeys: processedKeys
      })
    };
  } catch (error) {
    console.error('Error processing image:', error);
    throw error;
  }
};

async function addWatermark(imageBuffer, text, width) {
  // Use Sharp to add text watermark
  const textSvg = `
    <svg width="${width}" height="50">
      <style>
        .title { fill: rgba(255,255,255,0.7); font-size: ${Math.max(16, width / 20)}px; font-weight: bold; }
      </style>
      <text x="95%" y="80%" text-anchor="end" class="title">${text}</text>
    </svg>
  `;
  
  const textBuffer = Buffer.from(textSvg);
  
  return await sharp(imageBuffer)
    .composite([{ input: textBuffer, gravity: 'southeast' }])
    .toBuffer();
}