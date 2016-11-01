var previousTarget, currentTarget,
	zoomable = true,
	zoomLevels = [1, 1.25, 1.5, 1.75, 2.0],
	zoomState,
	initialZoom = 2,
	zoomNow = false;


function largeImageHeight(){
	var images = document.querySelectorAll('.large-image-area img'),
		maxImageHeight = images[0].clientHeight;

	for(var i = 1, x = images.length; i < x; i++){
		if(images[i].clientHeight > maxImageHeight){
			maxImageHeight = images[i].clientHeight;
		}
	}

	console.log(maxImageHeight + ' ' + zoomState + ' ' + zoomNow);
	if(zoomNow) maxImageHeight /= zoomState;

	document.querySelectorAll('.large-image-area')[0].style.minHeight = maxImageHeight + 'px';
}

function showFirst(){
	var images = document.querySelectorAll('.large-image-area img');

	currentTarget = 0;
	previousTarget = 0;
	zoomState = initialZoom;
  if(document.querySelector('.large-image-area') !=null){
	  document.querySelector('.large-image-area').style.cursor = 'crosshair';
  }
  if(images.length >0){
  	images[0].classList.add('show-imidiate');
  	for(var i = 1, x = images.length; i < x; i++){
  		images[i].classList.add('hide-imidiate');
  	}
    largeImageHeight();
  }

	
}

function clearAll(){
	var images = document.querySelectorAll('.large-image-area img');
	for(var i = 0, x = images.length; i < x; i++){
		images[i].classList.remove('show-imidiate', 'hide-imidiate', 'show-content', 'hide-content');
	}
}

function smallImageClick (event) {
	var thumbnails = document.querySelectorAll('.thumbnail-area img'),
		images = document.querySelectorAll('.large-image-area img');

	for(var i = 0, x = thumbnails.length; i < x; i++){
		if(event.target == thumbnails[i]){
			currentTarget = i;
			break;
		}
	}
	
	if(currentTarget == previousTarget) return;

	clearAll();

	for(i = 0, x = images.length; i < x; i++){
		images[i].classList.add('hide-imidiate');
	}

	images[currentTarget].classList.add('show-content');
	images[previousTarget].classList.add('hide-content');
	
	previousTarget = currentTarget;
}

function moveImage(event){

	if(!zoomable) return;

	var imageDiv = document.querySelector('.large-image-area'),
		images = document.querySelectorAll('.large-image-area img')
		rect = imageDiv.getBoundingClientRect(),
		divY = event.clientY - rect.top;
		divX = event.clientX - rect.left;

	for(var i = 0, x = images.length; i < x; i++){
		images[i].style.width = zoomLevels[zoomState]*100 + '%';
		images[i].style.top = '-'+ divY*(zoomLevels[zoomState]-1) + 'px';
		images[i].style.left = '-' + divX*(zoomLevels[zoomState]-1) + 'px';
	}

	zoomNow = true;
}

function normalImage(event){

	if(!zoomable) return;

	var images = document.querySelectorAll('.large-image-area img');
	for(var i = 0, x = images.length; i < x; i++){
		images[i].style.width = '100%';
		images[i].style.top ='0px';
		images[i].style.left = '0px';
	}
	zoomNow = false;
}

function showCenter(){
	var imageDiv = document.querySelector('.large-image-area'),
		images = document.querySelectorAll('.large-image-area img'),
		rect = imageDiv.getBoundingClientRect(),
		size = zoomLevels[zoomState]*100,
		top = -(rect.bottom - rect.top)/2 * (zoomLevels[zoomState] - 1),
		left = -(rect.right - rect.left)/2 * (zoomLevels[zoomState] - 1);

	zoomNow = true;

	if(!zoomable){
		size = 100;
		top = 0;
		left = 0;
		zoomNow = false;
	}

	for(var i = 0, x = images.length; i < x; i++){
		images[i].style.width = size + '%';
		images[i].style.top = top + 'px';
		images[i].style.left = left + 'px';
	}
}

function disableEnableZoomColor(){
	var zoomInButton = document.getElementById('zoom-in'),
		zoomOutButton = document.getElementById('zoom-out'),
		toggleZoomButton = document.getElementById('toggle-zoom'),
		imageArea = document.getElementsByClassName('large-image-area')[0];;

	if(zoomable){
		toggleZoomButton.style.color = '#C6C6C6';
		imageArea.style.cursor = 'crosshair';

		controlColors();
	}else{
		toggleZoomButton.style.color = '#373a3c';
		imageArea.style.cursor = 'pointer';
		
		zoomInButton.style.color = '#C6C6C6';
		zoomOutButton.style.color = '#C6C6C6';
		zoomInButton.style.cursor = 'default';
		zoomOutButton.style.cursor = 'default';
	}
}

function controlColors(){
	var zoomInButton = document.getElementById('zoom-in'),
		zoomOutButton = document.getElementById('zoom-out');

	zoomInButton.style.color = '#373A3C';
	zoomOutButton.style.color = '#373A3C';
	zoomInButton.style.cursor = 'pointer';
	zoomOutButton.style.cursor = 'pointer';

	if(zoomState == zoomLevels.length-1){
		zoomInButton.style.color = '#C6C6C6';
		zoomInButton.style.cursor = 'default';
	}

	if(zoomState == 0){
		zoomOutButton.style.color = '#C6C6C6';
		zoomOutButton.style.cursor = 'default';	
	}
}

function zoomIn(){

	if(!zoomable){
		disableZoomColor();
		return;
	}

	if(zoomState < zoomLevels.length - 1){
		zoomState++;
		showCenter();
	}

	controlColors();
}

function zoomOut(){

	if(!zoomable){
		disableZoomColor();
		return;
	}

	if(zoomState > 0){
		zoomState--;
		showCenter();
	}

	controlColors();
}

function resetZoom(){
	zoomState = initialZoom;
	zoomable = true;
	disableEnableZoomColor();
	showCenter();
}

function toggleZoom(event){
	zoomable = !zoomable;
	disableEnableZoomColor();
	showCenter();
}
if(document.getElementsByClassName('thumbnail-area').length >0){
  document.getElementsByClassName('thumbnail-area')[0].addEventListener('click', smallImageClick);
}
if(document.getElementsByClassName('large-image-area').length >0){
  document.getElementsByClassName('large-image-area')[0].addEventListener('mousemove', moveImage);
  document.getElementsByClassName('large-image-area')[0].addEventListener('mouseout', normalImage);
}
if(document.getElementById('zoom-in')!=null){
document.getElementById('zoom-in').addEventListener('click', zoomIn);
}
if(document.getElementById('zoom-out') !=null){
document.getElementById('zoom-out').addEventListener('click', zoomOut);
}
if(document.getElementById('reset-zoom')!=null){
document.getElementById('reset-zoom').addEventListener('click', resetZoom);
}
if(document.getElementById('toggle-zoom')!=null){
document.getElementById('toggle-zoom').addEventListener('click', toggleZoom);
}


// window.addEventListener('load', showFirst);
// window.addEventListener('resize', largeImageHeight);
$(document).ready(function () {
  // Works only on `data-parsley-validate`.
  if($('.validate-form').length >0){
    $('.validate-form').parsley();
   }
});