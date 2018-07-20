using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PanoController : MonoBehaviour
{
	public InputField m_latInputfield;
    public InputField m_lonInputfield;
	public Button m_panoButton;

	void Awake()
	{
		m_panoButton.onClick.AddListener(() => OpenPano());
	}

	void OnDestroy()
	{
		m_panoButton.onClick.RemoveListener(() => OpenPano());
	}

	public void OpenPano()
	{
		double lat = double.Parse(m_latInputfield.text);
		double lon = double.Parse(m_lonInputfield.text);
		OSBridge.InitPano(lat, lon);
	}
}
