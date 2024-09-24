import cv2
import win32com.client


def get_camera_details_windows():
    cameras = {}
    try:
        wmi = win32com.client.GetObject("winmgmts:")
        # Look into video input devices rather than limiting to 'camera' or 'video'
        for item in wmi.InstancesOf("Win32_PnPEntity"):
            # Broadening check using typical keywords associated with cameras
            if any(keyword in (item.Description or "").lower() for keyword in ["camera", "capture", "video", "input", "virtual"]):
                cameras[item.DeviceID] = item.Name
    except Exception as e:
        print(f"Error accessing WMI: {e}")
    return cameras


def get_available_cameras(max_cameras=4):
    available_cameras = []

    for i in range(max_cameras):
        cap = cv2.VideoCapture(i)
        print(i)
        try:
            if cap.isOpened():
                available_cameras.append(i)
                cap.release()
        except Exception as e:
            print(e, ' has occurred.')
    return available_cameras


def update_camera_descriptions():
    camera_details = get_camera_details_windows()
    available_cameras = get_available_cameras()
    mapped_descriptions = []
    # print(camera_details, available_cameras)
    # Attempt to match each available camera to a device description
    for idx in available_cameras:
        description = f"Camera {idx}"
        if idx < len(camera_details):
            # Assign description based on the index
            description_items = list(camera_details.items())
            description = description_items[idx][1]
        mapped_descriptions.append((description, idx))

    return mapped_descriptions

if __name__ == '__main__':
    print(update_camera_descriptions())